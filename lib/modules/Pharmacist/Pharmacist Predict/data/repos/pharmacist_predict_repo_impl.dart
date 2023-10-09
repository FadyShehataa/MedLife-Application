// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Predict/data/models/drug_prediction.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Predict/data/models/predict_product_info_model.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Predict/data/repos/pharmacist_predict_repo.dart';

class PharmacistPredictRepoImpl implements PharmacistPredictRepo {
  ApiService apiService;
  PharmacistPredictRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<PredictProductInfoModel>>>
      fetchPredictProducts() async {
    try {
      var data = await apiService.get(endPoint: 'ml/product/names');

      List<PredictProductInfoModel> predictProducts = [];

      for (int i = 0; i < 8; i++) {
        predictProducts.add(PredictProductInfoModel.fromJson(data['$i']));
      }

      return right(predictProducts);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DrugPredictionModel>> fetchDrugPrediction(
      {dynamic bodyRequest}) async {
    try {
      var data = await apiService.post(
          endPoint: 'ml/predict', bodyRequest: bodyRequest);

      DrugPredictionModel drugPredictionModel =
          DrugPredictionModel.fromJson(data);

      return right(drugPredictionModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
