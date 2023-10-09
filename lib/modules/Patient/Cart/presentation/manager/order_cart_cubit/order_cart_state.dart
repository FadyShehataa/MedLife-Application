part of 'order_cart_cubit.dart';

@immutable
abstract class OrderCartState {}

class OrderCartInitial extends OrderCartState {}

class OrderCartLoading extends OrderCartState {}
class OrderCartSuccess extends OrderCartState {}
class OrderCartFailure extends OrderCartState {
  final String errMessage;

  OrderCartFailure({required this.errMessage});

}

