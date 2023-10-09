import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../Prescription%20OCR/data/models/prescription_model/prescription_model.dart';

import '../../../Patient Home/data/models/pharmacy_model/pharmacy_model.dart';
import '../../../Patient Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';
import 'search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  ApiService apiService;
  SearchRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<PharmacyModel>>> fetchPharmacies(
      {required String pharmacyName}) async {
    try {
      var data = await apiService.get(
          endPoint: 'patient/pharmacies?name=$pharmacyName');

      List<PharmacyModel> pharmacies = [];

      for (var item in data['pharmacies']) {
        pharmacies.add(PharmacyModel.fromJson(item));
      }
      return right(pharmacies);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PharmacyProductModel>>> fetchProductInPharmacy(
      {required String productName, required String pharmacyId}) async {
    try {
      var data = await apiService.get(
          endPoint:
              'product/system/products/pharmacy/$pharmacyId?name=$productName');
      List<PharmacyProductModel> products = [];

      for (var item in data['products']) {
        products.add(PharmacyProductModel.fromJson(item));
      }
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PrescriptionModel>>> fetchProductInPharmacies(
      {required String productName}) async {
    try {
      var data = await apiService.get(
          endPoint: 'product/system/products/product?name=$productName');

      List<PrescriptionModel> products = [];

      for (var item in data['products']) {
        products.add(PrescriptionModel.fromJson(item));
      }
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
