import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../manager/cart_cubit/cart_cubit.dart';
import '../check_out_screen.dart';
import '../../../../../../core/utils/constants.dart';
import 'cart_item.dart';
import 'custom_elevated_button.dart';

class CartBody extends StatelessWidget {
  final double scale;
  const CartBody({Key? key, required this.scale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: ((context, state) {
        if (state is CartSuccess) {
          if (state.cart.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 30, left: 15, right: 15),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cart.length,
                      itemBuilder: ((context, index) {
                        return CartItem(
                          cartItem: state.cart[index],
                          scale: scale,
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 10 * scale),
                  Divider(
                    thickness: 2 * scale,
                    color: MyColors.myGrey.withOpacity(0.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: MyColors.myBlack.withOpacity(0.8),
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${BlocProvider.of<CartCubit>(context).totalPrice.toString()} EGP',
                        style: TextStyle(
                          color: MyColors.myBlack.withOpacity(0.8),
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15 * scale),
                  CustomElevatedButton(
                    child: Text(
                      'Proceed to checkout',
                      style: TextStyle(fontSize: 18 * scale),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CheckOutView(),
                        ),
                      );
                    },
                  ),
                  if (scale != 1) const SizedBox(height: 25)
                ],
              ),
            );
          } else {
            return const CustomEmptyWidget(
              image: "assets/images/Empty_Cart.png",
              title: 'No Items',
              subTitle: 'Go Back and Select your items',
            );
          }
        } else if (state is CartFailure) {
          return CustomErrorWidget(
            errMessage: state.errMessage,
          );
        } else if (state is CartLoading) {
          return const CustomLoadingIndicator();
        }
        return Container();
      }),
    );
  }
}
