part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartFailure extends CartState {
  final String errMessage;

  CartFailure({required this.errMessage});
}

class CartSuccess extends CartState {
  final List<CartModel> cart;

  CartSuccess({required this.cart});
}

class UpdatePosition extends CartState {}
