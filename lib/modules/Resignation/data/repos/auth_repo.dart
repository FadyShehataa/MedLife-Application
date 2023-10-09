import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> loginPharmacist({dynamic bodyRequest});

  Future<Either<Failure, void>> loginPatient({dynamic bodyRequest});

  Future<Either<Failure, Map<String, dynamic>>> signUpPatient(
      {dynamic bodyRequest});

  Future<Either<Failure, Map<String, dynamic>>> signUpPharmacist({
    required XFile? pickedFile,
    required String name,
    required String email,
    required String password,
    required String pharmacyName,
    required double lat,
    required double lng,
  });

  Future<Either<Failure, Map<String, dynamic>>> verificationCodePatient(
      {dynamic bodyRequest});

  Future<Either<Failure, Map<String, dynamic>>> verificationCodePharmacist(
      {dynamic bodyRequest});
}
