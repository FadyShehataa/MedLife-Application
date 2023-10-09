import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';

abstract class PatientProfileRepo {
  Future<Either<Failure, void>> editPatientPassword({dynamic bodyRequest});
  Future<Either<Failure, void>> editPatientName({dynamic bodyRequest});
  Future<Either<Failure, void>> updateImage({dynamic pickedImage});
  Future<Either<Failure, void>> deleteImage();
}
