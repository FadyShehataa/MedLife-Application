part of 'pharmacist_profile_cubit.dart';

@immutable
abstract class PharmacistProfileState {}

class PharmacistProfileInitial extends PharmacistProfileState {}

class PharmacistProfileLoading extends PharmacistProfileState {}

class ImgVisibility extends PharmacistProfileState {}

class PharmacistProfileFailure extends PharmacistProfileState {
  final String errMessage;

  PharmacistProfileFailure({required this.errMessage});
}

class EditPharmacistNameSuccess extends PharmacistProfileState {}
class EditPharmacyNameSuccess extends PharmacistProfileState {}
class EditPasswordSuccess extends PharmacistProfileState {}

class PharmacistProfileSucess extends PharmacistProfileState {}