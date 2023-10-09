// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Home/data/models/category_model/category_model.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Home/data/models/pharmacy_model/pharmacy_model.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Home/data/repos/patient_home_repo.dart';

class PatientHomeRepoImpl implements PatientHomeRepo {
  ApiService apiService;
  PatientHomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<PharmacyModel>>> fetchPharmacies() async {
    try {
      var data = await apiService.get(endPoint: 'patient/pharmacies');

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
  Future<Either<Failure, List<PharmacyModel>>> fetchBestPharmacies() async {
    try {
      var data = await apiService.get(
          endPoint: 'patient/top-rated-pharmacies?amount=2');

      List<PharmacyModel> bestPharmacies = [];

      for (var item in data['pharmacies']) {
        bestPharmacies.add(PharmacyModel.fromJson(item));
      }
      return right(bestPharmacies);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      var data =
          await apiService.get(endPoint: 'product/system/products/category');

      List<CategoryModel> categories = [];

      for (int i = 0; i < 6; i++) {
        categories.add(CategoryModel.fromJson(data['$i']));
      }
      return right(categories);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PharmacyProductModel>>>
      fetchPharmacyProducts({required String pharmacyID}) async {
    try {
      var data = await apiService.get(
          endPoint: 'product/system/products/pharmacy/$pharmacyID');

      List<PharmacyProductModel> pharmacyProducts = [];

      for (var item in data['products']) {
        pharmacyProducts.add(PharmacyProductModel.fromJson(item));
      }
      return right(pharmacyProducts);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reviewPharmacy(
      {required String pharmacyID, bodyRequest}) async {
    try {
      var data = await apiService.post(
          endPoint: 'patient/pharmacy-reviews/$pharmacyID/review',
          bodyRequest: bodyRequest);
      if (data['review'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
