part of 'pharmacy_products_cubit.dart';

@immutable
abstract class PharmacyProductsState {}

class PharmacyProductsInitial extends PharmacyProductsState {}

class PharmacyProductsLoading extends PharmacyProductsState {}

class PharmacyProductsFailure extends PharmacyProductsState {
  final String errMessage;

  PharmacyProductsFailure({required this.errMessage});
}

class PharmacyProductsSuccess extends PharmacyProductsState {
  final List<PharmacyProductModel> pharmacyProducts;

  PharmacyProductsSuccess({required this.pharmacyProducts});
}
