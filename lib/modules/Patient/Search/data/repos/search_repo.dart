import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../Prescription%20OCR/data/models/prescription_model/prescription_model.dart';

import '../../../Patient Home/data/models/pharmacy_model/pharmacy_model.dart';
import '../../../Patient Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';


abstract class SearchRepo {
  Future<Either<Failure, List<PharmacyModel>>> fetchPharmacies({required String pharmacyName});

  Future<Either<Failure, List<PharmacyProductModel>>> fetchProductInPharmacy(
      {required String productName, required String pharmacyId});

  Future<Either<Failure, List<PrescriptionModel>>> fetchProductInPharmacies(
      {required String productName});
}
