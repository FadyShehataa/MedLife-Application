import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../Patient%20Home/data/models/category_model/category_model.dart';
import '../../../Patient%20Home/data/models/pharmacy_model/pharmacy_model.dart';
import '../../../Patient%20Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';

abstract class PatientHomeRepo {
  Future<Either<Failure, List<PharmacyModel>>> fetchPharmacies();
  Future<Either<Failure, List<PharmacyModel>>> fetchBestPharmacies();

  Future<Either<Failure, List<CategoryModel>>> fetchCategories();



  
  Future<Either<Failure, void>>
      reviewPharmacy({required String pharmacyID, dynamic bodyRequest});

  Future<Either<Failure, List<PharmacyProductModel>>>
      fetchPharmacyProducts({required String pharmacyID});

}
