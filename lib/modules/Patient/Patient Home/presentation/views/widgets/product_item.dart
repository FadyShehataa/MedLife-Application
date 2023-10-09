import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Cart/presentation/manager/cart_cubit/cart_cubit.dart';
import '../../../../Patient%20Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';
import '../../../../Patient%20Home/presentation/views/widgets/patient_product_details_view_body.dart';
import '../../../../../../core/utils/constants.dart';
import 'package:sizer/sizer.dart';

import '../../../../Favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.productModel,
  }) : super(key: key);
  final PharmacyProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return PatientProductsDetailsViewBody(
              images: productModel.product!.images!,
              price: productModel.price,
              name: productModel.product!.name!,
              id: productModel.id,
            );
          }),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        width: 170,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: MyColors.myWhite,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: productModel.product!.images![0],
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 40,
                        ),
                        // placeholder: (context, url) => const CustomLoadingIndicator(),
                      ),
                    ),
                    //child: Image.network(productModel.product!.images![0]),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // flex: ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productModel.product!.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(productModel.product!.type!),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                '\$ ${productModel.price.toString()}',
                                style: const TextStyle(
                                  color: MyColors.myPurple,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              bool itemInCart =
                                  BlocProvider.of<CartCubit>(context).cart.any(
                                      (element) =>
                                          element.id == productModel.id);
                              return IconButton(
                                color: itemInCart
                                    ? MyColors.myBlue
                                    : Colors.grey, //Colors.blue : Colors.grey,
                                onPressed: () async {
                                  if (itemInCart) {
                                    String quantity =
                                        BlocProvider.of<CartCubit>(context)
                                            .cart
                                            .firstWhere((element) =>
                                                element.id == productModel.id)
                                            .quantity!
                                            .toString();

                                    BlocProvider.of<CartCubit>(context)
                                        .deleteItemFromCart(
                                            cartID: productModel.id!,
                                            quantity: quantity);
                                  } else {
                                    await BlocProvider.of<CartCubit>(context)
                                        .addItemToCart(
                                            cartID: productModel.id!);

                                    if (BlocProvider.of<CartCubit>(
                                                context)
                                            .notifyMe ==
                                        true) {
                                      _showPopup(context);
                                      BlocProvider.of<CartCubit>(context)
                                          .notifyMe = false;
                                    }
                                    //get response message and show pop up
                                  }
                                },
                                icon: itemInCart
                                    ? const Icon(Icons.shopping_cart)
                                    : const Icon(Icons.shopping_cart),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  bool itemInFavorite = BlocProvider.of<FavoriteCubit>(context)
                      .favorites
                      .any((element) => element.id == productModel.id);
                  return IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 20.sp,
                      color: itemInFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      if (itemInFavorite) {
                        BlocProvider.of<FavoriteCubit>(context)
                            .deleteItemFromFavorite(cartID: productModel.id!);
                      } else {
                        BlocProvider.of<FavoriteCubit>(context)
                            .addItemToFavorite(cartID: productModel.id!);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reminder'),
          content: const Text(
              'This product Is not available!! Do you want to get notified when available?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Notify me!!'),
              onPressed: () {
                // Perform the request here
                BlocProvider.of<CartCubit>(context).notifyMeWhenAvailable(
                    productId: productModel.product!.id,
                    pharmacyId: productModel.pharmacy);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
