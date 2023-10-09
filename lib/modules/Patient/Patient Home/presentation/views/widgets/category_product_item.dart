import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Cart/presentation/manager/cart_cubit/cart_cubit.dart';
import '../../../../Favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import '../../../../Patient%20Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';
import '../../../../Patient%20Home/presentation/views/widgets/patient_product_details_view_body.dart';
import '../../../../../../core/utils/constants.dart';

class CategoryProductItem extends StatelessWidget {
  final PharmacyProductModel pharmacyProductModel;
  final double scale;

  const CategoryProductItem(
      {Key? key, required this.pharmacyProductModel, required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return PatientProductsDetailsViewBody(
              images: pharmacyProductModel.product!.images,
              price: pharmacyProductModel.price,
              name: pharmacyProductModel.product!.name,
              id: pharmacyProductModel.id,
            );
          }),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        color: MyColors.myBackGround2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 3.35 / 3.2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            pharmacyProductModel.product!.images![0]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pharmacyProductModel.product!.name!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          BlocBuilder<FavoriteCubit, FavoriteState>(
                            builder: (context, state) {
                              bool itemInFavorite =
                                  BlocProvider.of<FavoriteCubit>(context)
                                      .favorites
                                      .any((element) =>
                                          element.id ==
                                          pharmacyProductModel.id);
                              return IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  // size: 20.sp,
                                  color:
                                      itemInFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  if (itemInFavorite) {
                                    BlocProvider.of<FavoriteCubit>(context)
                                        .deleteItemFromFavorite(
                                            cartID: pharmacyProductModel.id!);
                                  } else {
                                    BlocProvider.of<FavoriteCubit>(context)
                                        .addItemToFavorite(
                                            cartID: pharmacyProductModel.id!);
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const Spacer(),
                      Text(
                        pharmacyProductModel.product!.type!,
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      const Spacer(flex: 3),
                      Row(
                        children: [
                          Text(
                            '${pharmacyProductModel.price.toString()} EGP',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                                  bool itemInCart =
                                      BlocProvider.of<CartCubit>(context)
                                          .cart
                                          .any((element) =>
                                              element.id ==
                                              pharmacyProductModel.id);
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: itemInCart
                                          ? Colors.grey
                                          : MyColors.myBlue, //Colors.blue,
                                    ),
                                    onPressed: () {
                                      if (itemInCart) {
                                        String quantity =
                                            BlocProvider.of<CartCubit>(context)
                                                .cart
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    pharmacyProductModel.id)
                                                .quantity!
                                                .toString();

                                        BlocProvider.of<CartCubit>(context)
                                            .deleteItemFromCart(
                                                cartID:
                                                    pharmacyProductModel.id!,
                                                quantity: quantity);
                                      } else {
                                        BlocProvider.of<CartCubit>(context)
                                            .addItemToCart(
                                                cartID:
                                                    pharmacyProductModel.id!);
                                      }
                                    },
                                    child: itemInCart
                                        ? const Text('Added to cart')
                                        : const Text('Add to cart'),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
