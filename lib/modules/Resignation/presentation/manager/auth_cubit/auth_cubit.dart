import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;
  late bool isPassword = true;

  Position? currentPosition;
  File? img;

  static AuthCubit get(context) => BlocProvider.of(context);

  void uploadImage(pickedImage) {
    img = pickedImage;
    emit(UploadImage());
  }

  void updatePosition(position) {
    currentPosition = position;
    emit(UpdatePosition());
  }

  void passwordVisibility() {
    isPassword = !isPassword;
    emit(PasswordVisibility());
  }

  Future<void> loginPharmacist({dynamic bodyRequest}) async {
    emit(AuthLoading());
    var result = await authRepo.loginPharmacist(bodyRequest: bodyRequest);

    result.fold(
      (failure) {
        emit(AuthFailure(errMessage: failure.errMessage));
      },
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> loginPatient({dynamic bodyRequest}) async {
    emit(AuthLoading());
    var result = await authRepo.loginPatient(bodyRequest: bodyRequest);


    result.fold(
      (failure) {
        emit(AuthFailure(errMessage: failure.errMessage));
      },
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> signUpPatient({dynamic bodyRequest}) async {
    emit(SignUpPatientLoading());
    var result = await authRepo.signUpPatient(bodyRequest: bodyRequest);

    result.fold(
      (failure) => emit(SignUpPatientFailure(errMessage: failure.errMessage)),
      (data) => emit(SignUpPatientSuccess(data: data)),
    );
  }

  Future<void> signUpPharmacist({
    required XFile? pickedFile,
    required String name,
    required String email,
    required String password,
    required String pharmacyName,
    required double lat,
    required double lng,
  }) async {
    emit(SignUpPatientLoading());
    var result = await authRepo.signUpPharmacist(
      pickedFile: pickedFile,
      name: name,
      email: email,
      password: password,
      pharmacyName: pharmacyName,
      lat: lat,
      lng: lng,
    );

    result.fold(
      (failure) => emit(SignUpPatientFailure(errMessage: failure.errMessage)),
      (data) => emit(SignUpPatientSuccess(data: data)),
    );
  }

  Future<void> verificationCodePatient({dynamic bodyRequest}) async {
    emit(VerificationLoading());
    var result =
        await authRepo.verificationCodePatient(bodyRequest: bodyRequest);

    result.fold(
      (failure) => emit(VerificationFailure(errMessage: failure.errMessage)),
      (data) {
        if (data['extraData'] != null) {
          emit(VerificationFailureAllAttempts(data: data));
        } else {
          emit(VerificationSuccess(data: data));
        }
      },
    );
  }


  Future<void> verificationCodePharmacist({dynamic bodyRequest}) async {
    emit(VerificationLoading());
    var result =
    await authRepo.verificationCodePharmacist(bodyRequest: bodyRequest);

    result.fold(
          (failure) => emit(VerificationFailure(errMessage: failure.errMessage)),
          (data) {
        if (data['extraData'] != null) {
          emit(VerificationFailureAllAttempts(data: data));
        } else {
          emit(VerificationSuccess(data: data));
        }
      },
    );
  }

}
