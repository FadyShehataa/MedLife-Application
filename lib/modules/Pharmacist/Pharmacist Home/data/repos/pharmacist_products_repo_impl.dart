// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/modules/Pharmacist/Pharmacist%20Home/data/models/add_product_model/add_product_model.dart';
import 'package:medlife_app/modules/Pharmacist/Pharmacist%20Home/data/models/pharmacist_product_model/pharmacist_product_model.dart';
import 'package:medlife_app/modules/Pharmacist/Pharmacist%20Home/data/repos/pharmacist_products_repo.dart';

import '../../../../../core/utils/constants.dart';
import '../models/pharmacist_product_model/pharmacist_created_product_model.dart';

class PharmacistProductsRepoImpl implements PharmacistProductsRepo {
  ApiService apiService;
  PharmacistProductsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<PharmacistProductModel>>> fetchPharmacyProducts(
      {required String pharmacyID}) async {
    try {
      String pharmacyI = mainPharmacist!.pharmacyId!;

      var data = await apiService.get(
          endPoint: 'product/system/products/pharmacy/$pharmacyI');

      List<PharmacistProductModel> products = [];

      for (var item in data['products']) {
        products.add(PharmacistProductModel.fromJson(item));
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
  Future<Either<Failure, PharmacistProductModel>> deletePharmacyProduct(
      {required dynamic bodyRequest}) async {
    try {
      var data = await apiService.put(
          endPoint: 'product/pharmacy/products/modify',
          bodyRequest: bodyRequest);

      PharmacistProductModel product =
          PharmacistProductModel.fromJson(data['product']);

      return right(product);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PharmacistProductModel>> editPharmacyProduct(
      {dynamic bodyRequest}) async {
    try {
      var data = await apiService.put(
        endPoint: "product/pharmacy/products/modify",
        bodyRequest: bodyRequest,
      );
      PharmacistProductModel product =
          PharmacistProductModel.fromJson(data['product']);
      return right(product);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddProductModel>>> fetchSystemProducts() async {
    try {
      var data = await apiService.get(endPoint: 'product/system/products');

      List<AddProductModel> products = [];

      for (var item in data['products']) {
        products.add(AddProductModel.fromJson(item));
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
  Future<Either<Failure, CreatedPharmacistProductModel>> addProductToPharmacy(
      {dynamic bodyRequest}) async {
    try {
      var data = await apiService.post(
          endPoint: 'product/pharmacy/products/create',
          bodyRequest: bodyRequest);

      CreatedPharmacistProductModel product =
          CreatedPharmacistProductModel.fromJson(data['product']);

      return right(product);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
