import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../main.dart';
import '../manager/cart_cubit/cart_cubit.dart';
import 'widgets/cart_body.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    await BlocProvider.of<CartCubit>(context).fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    double scale = MyApp.isMobile ? 1 : 1.5 * 0.75;
    return Scaffold(
      body: CartBody(scale: scale),
    );
  }
}
