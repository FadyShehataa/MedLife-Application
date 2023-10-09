import 'package:dartz/dartz.dart';
import '../../../Pharmacist%20Home/data/models/add_product_model/add_product_model.dart';
import '../../../Pharmacist%20Home/data/models/pharmacist_product_model/pharmacist_product_model.dart';

import '../../../../../core/errors/failures.dart';
import '../models/pharmacist_product_model/pharmacist_created_product_model.dart';

abstract class PharmacistProductsRepo {
  Future<Either<Failure, List<PharmacistProductModel>>> fetchPharmacyProducts(
      {required String pharmacyID});

  Future<Either<Failure, PharmacistProductModel>> editPharmacyProduct(
      {dynamic bodyRequest});

  Future<Either<Failure, CreatedPharmacistProductModel>> addProductToPharmacy(
      {dynamic bodyRequest});

  Future<Either<Failure, PharmacistProductModel>> deletePharmacyProduct(
      {required dynamic bodyRequest});

  Future<Either<Failure, List<AddProductModel>>> fetchSystemProducts();
}
