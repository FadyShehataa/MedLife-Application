part of 'pharmacist_product_cubit.dart';

@immutable
abstract class PharmacistProductState {}

class PharmacistProductInitial extends PharmacistProductState {}

class PharmacistProductLoading extends PharmacistProductState {}

class PharmacistProductFailure extends PharmacistProductState {
  final String errMessage;

  PharmacistProductFailure({required this.errMessage});
}

class PharmacistProductSuccess extends PharmacistProductState {
  final List<PharmacistProductModel> products;

  PharmacistProductSuccess({required this.products});
}

class SearchQueryState extends PharmacistProductState {
  final String search;

  SearchQueryState({required this.search});
}
