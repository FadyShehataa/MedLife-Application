import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Cart/presentation/manager/cart_cubit/cart_cubit.dart';
import '../../../Favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import '../../../Patient%20Home/presentation/views/widgets/patient_product_details_view_body.dart';
import '../../../Prescription%20OCR/data/models/prescription_model/prescription_model.dart';
import '../../../../../core/utils/constants.dart';

class PrescriptionResultItem extends StatelessWidget {
  final PrescriptionModel prescriptionModel;
  final double scale;

  const PrescriptionResultItem(
      {Key? key, required this.prescriptionModel, required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return PatientProductsDetailsViewBody(
              images: prescriptionModel.product!.images!
                  .where((image) => image.url != null)
                  .map((image) => image.url!)
                  .toList(),
              price: prescriptionModel.price,
              name: prescriptionModel.product!.name!,
              id: prescriptionModel.id!,
            );
          }),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        color: MyColors.myBackGround2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 3.1 / 3.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: prescriptionModel.product!.images![0].url!,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: 40,
                      ),
                      // placeholder: (context, url) => const CustomLoadingIndicator(),
                    ),
                  ),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       fit: BoxFit.fill,
                  //       image: NetworkImage(
                  //           prescriptionModel.product!.images![0].url!),
                  //     ),
                  //   ),
                  // ),
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
                            prescriptionModel.product!.name!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          BlocBuilder<FavoriteCubit, FavoriteState>(
                            builder: (context, state) {
                              bool itemInFavorite =
                                  BlocProvider.of<FavoriteCubit>(context)
                                      .favorites
                                      .any((element) =>
                                          element.id == prescriptionModel.id);
                              return IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color:
                                      itemInFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  if (itemInFavorite) {
                                    BlocProvider.of<FavoriteCubit>(context)
                                        .deleteItemFromFavorite(
                                            cartID: prescriptionModel.id!);
                                  } else {
                                    BlocProvider.of<FavoriteCubit>(context)
                                        .addItemToFavorite(
                                            cartID: prescriptionModel.id!);
                                  }
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const Spacer(),
                      Text(
                        prescriptionModel.product!.type!,
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      const Spacer(),
                      Text(
                        prescriptionModel.product!.pharmacy!.name!,
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      const Spacer(flex: 3),
                      Row(
                        children: [
                          Text(
                            '${prescriptionModel.price.toString()} EGP',
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
                                  bool itemInCart = BlocProvider.of<CartCubit>(
                                          context)
                                      .cart
                                      .any((element) =>
                                          element.id == prescriptionModel.id);
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
                                                    prescriptionModel.id)
                                                .quantity!
                                                .toString();

                                        BlocProvider.of<CartCubit>(context)
                                            .deleteItemFromCart(
                                                cartID: prescriptionModel.id!,
                                                quantity: quantity);
                                      } else {
                                        BlocProvider.of<CartCubit>(context)
                                            .addItemToCart(
                                                cartID: prescriptionModel.id!);
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
