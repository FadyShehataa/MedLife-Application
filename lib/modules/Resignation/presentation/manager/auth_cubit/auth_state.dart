// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure({required this.errMessage});
}

class SignUpPatientSuccess extends AuthState {
  final Map<String, dynamic> data;
  SignUpPatientSuccess({required this.data});
}

class SignUpPatientLoading extends AuthState {}

class SignUpPatientFailure extends AuthState {
  final String errMessage;

  SignUpPatientFailure({required this.errMessage});
}

class VerificationLoading extends AuthState {}

class VerificationSuccess extends AuthState {
  final Map<String, dynamic> data;
  VerificationSuccess({required this.data});
}

class VerificationFailureAllAttempts extends AuthState {
  final Map<String, dynamic> data;
  VerificationFailureAllAttempts({required this.data});
}

class VerificationFailure extends AuthState {
  final String errMessage;

  VerificationFailure({required this.errMessage});
}

class PasswordVisibility extends AuthState {}

class UploadImage extends AuthState {}

class UpdatePosition extends AuthState {}
