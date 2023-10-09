part of 'patient_profile_cubit.dart';

@immutable
abstract class PatientProfileState {}

class PatientProfileInitial extends PatientProfileState {}

class PatientProfileLoading extends PatientProfileState {}

class ImgVisibility extends PatientProfileState {}

class PatientProfileFailure extends PatientProfileState {
  final String errMessage;

  PatientProfileFailure({required this.errMessage});
}

class PatientProfileSuccess extends PatientProfileState {}
