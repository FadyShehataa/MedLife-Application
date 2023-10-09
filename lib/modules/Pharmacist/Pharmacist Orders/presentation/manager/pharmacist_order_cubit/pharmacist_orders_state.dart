part of 'pharmacist_orders_cubit.dart';

@immutable
abstract class PharmacistOrdersState {}

class PharmacistOrdersInitial extends PharmacistOrdersState {}

class PharmacistOrdersLoading extends PharmacistOrdersState {}

class PharmacistOrdersFailure extends PharmacistOrdersState {
  final String errMessage;

  PharmacistOrdersFailure({required this.errMessage});
}

class PharmacistOrdersSuccess extends PharmacistOrdersState {
  final List<PharmacistOrderModel> orders;

  PharmacistOrdersSuccess({required this.orders});
}

class SearchQueryState extends PharmacistOrdersState {
  final String orderStatus;

  SearchQueryState({required this.orderStatus});
}
