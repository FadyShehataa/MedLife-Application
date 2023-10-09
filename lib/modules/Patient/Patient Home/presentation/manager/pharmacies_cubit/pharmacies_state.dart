part of 'pharmacies_cubit.dart';

@immutable
abstract class PharmaciesState {}

class PharmaciesInitial extends PharmaciesState {}

class PharmaciesLoading extends PharmaciesState {}

class PharmaciesFailure extends PharmaciesState {
  final String errMessage;

  PharmaciesFailure({required this.errMessage});
}

class PharmaciesSuccess extends PharmaciesState {
  final List<PharmacyModel> pharmacies;

  PharmaciesSuccess({required this.pharmacies});
}