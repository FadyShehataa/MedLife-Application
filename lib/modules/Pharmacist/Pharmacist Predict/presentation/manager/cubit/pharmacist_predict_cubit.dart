import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Predict/data/models/predict_product_info_model.dart';
import '../../../../Pharmacist%20Predict/data/repos/pharmacist_predict_repo.dart';

import '../../../data/models/drug_prediction.dart';

part 'pharmacist_predict_state.dart';

class PharmacistPredictCubit extends Cubit<PharmacistPredictState> {
  PharmacistPredictCubit(this.pharmacistPredictRepo)
      : super(PharmacistPredictInitial());

  final PharmacistPredictRepo pharmacistPredictRepo;
  TextEditingController searchPredictProductsController =
      TextEditingController();
  List<PredictProductInfoModel> predictProducts = [];
  DrugPredictionModel drugPrediction = DrugPredictionModel(year: [], month: [], day: [], drug: [], predictedQuantity: []);

  Future<void> fetchPredictProducts() async {
    emit(PharmacistPredictLoading());

    var result = await pharmacistPredictRepo.fetchPredictProducts();

    result.fold(
      (failure) =>
          emit(PharmacistPredictFailure(errMessage: failure.errMessage)),
      (predictProducts) {
        emit(PharmacistPredictSuccess(predictProducts: predictProducts));
        this.predictProducts = predictProducts;
      },
    );
  }

  Future<void> searchPredictProductsQuery(String query) async {
    emit(SearchQueryState(search: query));
    searchPredictProductsController.text = query;
  }

  Future<void> fetchDrugPrediction({dynamic bodyRequest}) async {
    emit(PharmacistDrugPredictionLoading());

    var result = await pharmacistPredictRepo.fetchDrugPrediction(
        bodyRequest: bodyRequest);

    result.fold(
      (failure) =>
          emit(PharmacistDrugPredictionFailure(errMessage: failure.errMessage)),
      (drugPrediction) {
        emit(PharmacistDrugPredictionSuccess(drugPrediction: drugPrediction));
        this.drugPrediction = drugPrediction;

      }
    );
  }
}
