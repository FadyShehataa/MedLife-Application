import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/cart_model/cart_model.dart';
import '../../../../Patient%20Home/presentation/views/widgets/patient_product_details_view_body.dart';
import '../../../../../../core/utils/components.dart';
import '../../../../../../core/utils/constants.dart';
import '../../manager/cart_cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  final CartModel cartItem;
  final double scale;
  const CartItem({Key? key, required this.cartItem, required this.scale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return PatientProductsDetailsViewBody(
              images: cartItem.product!.images!
                  .where((image) => image.url != null)
                  .map((image) => image.url!)
                  .toList(),
              price: cartItem.price,
              name: cartItem.product!.name,
              id: cartItem.id,
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
                      imageUrl: cartItem.product!.images![0].url!,
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
                  //       image: NetworkImage(cartItem.product!.images![0].url!),
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
                            cartItem.product!.name!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            iconSize: scale == 1 ? null : 50,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              BlocProvider.of<CartCubit>(context)
                                  .deleteItemFromCart(
                                cartID: cartItem.id!,
                                quantity: cartItem.quantity!.toString(),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: MyColors.myRed,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(flex: 1),
                      Text(
                        cartItem.product!.type!,
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      const Spacer(flex: 1),
                      Text(
                        cartItem.pharmacyName!,
                        style: const TextStyle(color: MyColors.myGrey),
                      ),
                      const Spacer(flex: 3),
                      Row(
                        children: [
                          Text(
                            '${cartItem.price.toString()} EGP',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  BlocProvider.of<CartCubit>(context)
                                      .decreaseItemFromCart(
                                    cartID: cartItem.id!,
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  color: MyColors.myBackGround,
                                  child: Icon(
                                    Icons.remove,
                                    size: scale == 1 ? null : 50,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                cartItem.quantity.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  if (cartItem.quantity! == cartItem.amount) {
                                    showError("Maximum Stock Reached");
                                  } else {
                                    BlocProvider.of<CartCubit>(context)
                                        .addItemToCart(cartID: cartItem.id!);
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  color: MyColors.myBlue,
                                  child: Icon(
                                    Icons.add,
                                    color: MyColors.myWhite,
                                    size: scale == 1 ? null : 50,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
