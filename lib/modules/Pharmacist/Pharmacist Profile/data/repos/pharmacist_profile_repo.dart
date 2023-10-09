import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

abstract class PharmacistProfileRepo {
  Future<Either<Failure, void>> editPharmacistPassword({dynamic bodyRequest});
  Future<Either<Failure, void>> editPharmacistName({dynamic bodyRequest});
  Future<Either<Failure, void>> editPharmacyName(
      {dynamic bodyRequest});

  Future<Either<Failure, void>> updateImage({dynamic pickedImage});

  Future<Either<Failure, void>> deleteImage();


}
