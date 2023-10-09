part of 'best_pharmacies_cubit.dart';

@immutable
abstract class BestPharmaciesState {}

class BestPharmaciesInitial extends BestPharmaciesState {}

class BestPharmaciesLoading extends BestPharmaciesState {}

class BestPharmaciesFailure extends BestPharmaciesState {
  final String errMessage;

  BestPharmaciesFailure({required this.errMessage});
}

class BestPharmaciesSuccess extends BestPharmaciesState {
  final List<PharmacyModel> bestPharmacies;

  BestPharmaciesSuccess({required this.bestPharmacies});
}