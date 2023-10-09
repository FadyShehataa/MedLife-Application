import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Prescription%20OCR/data/models/prescription_model/prescription_model.dart';

import '../../../../../core/errors/failures.dart';

abstract class PrescriptionOCRRepo{

  Future<Either<Failure, List<PrescriptionModel>>> fetchPrescription({XFile? pickedFile});


}