import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Cart/presentation/manager/cart_cubit/cart_cubit.dart';
import '../../../../Patient%20Home/presentation/views/widgets/patient_product_details_view_body.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../data/model/favorite_model/favorite_model.dart';
import '../../manager/favorite_cubit/favorite_cubit.dart';

class MedicineFavoriteItem extends StatelessWidget {
  final FavoriteModel favItem;
  final double scale;

  const MedicineFavoriteItem(
      {Key? key, required this.favItem, required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return PatientProductsDetailsViewBody(
              images: favItem.product!.images!.where((image) => image.url != null).map((image) => image.url!).toList(),
              price: favItem.price,
              name: favItem.product!.name,
              id: favItem.id,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: favItem.product!.images![0].url!,
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
                  //       image: NetworkImage(favItem.product!.images![0].url!),
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
                            favItem.product!.name!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            iconSize: scale == 1 ? null : 50,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              BlocProvider.of<FavoriteCubit>(context)
                                  .deleteItemFromFavorite(cartID: favItem.id!);
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: MyColors.myRed,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Text(
                        favItem.product!.type!,
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      const Spacer(flex: 3),
                      Row(
                        children: [
                          Text(
                            '${favItem.price.toString()} EGP',
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
                                      .any((element) => element.id == favItem.id);
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          itemInCart ? Colors.grey : MyColors.myBlue, //Colors.blue,
                                    ),
                                    onPressed: () {
                                      if (itemInCart) {
                                        String quantity =
                                            BlocProvider.of<CartCubit>(context)
                                                .cart
                                                .firstWhere((element) =>
                                                    element.id == favItem.id)
                                                .quantity!
                                                .toString();
    
                                        BlocProvider.of<CartCubit>(context)
                                            .deleteItemFromCart(
                                                cartID: favItem.id!,
                                                quantity: quantity);
                                      } else {
                                        BlocProvider.of<CartCubit>(context)
                                            .addItemToCart(cartID: favItem.id!);
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
