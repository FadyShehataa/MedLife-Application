// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchFailure extends SearchState {
  final String errMessage;

  SearchFailure({required this.errMessage});
}

class SearchPharmacySuccess extends SearchState {
  final List<PharmacyModel> pharmacies;
  SearchPharmacySuccess({required this.pharmacies});
}

class SearchProductInPharmacySuccess extends SearchState {
  final List<PharmacyProductModel> products;
  SearchProductInPharmacySuccess({required this.products});
}

class SearchProductInPharmaciesSuccess extends SearchState {
  final List<PrescriptionModel> products;
  SearchProductInPharmaciesSuccess({required this.products});
}

class UpdatePosition extends SearchState {}