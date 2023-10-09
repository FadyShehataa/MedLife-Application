part of 'pharmacist_predict_cubit.dart';

@immutable
abstract class PharmacistPredictState {}

class PharmacistPredictInitial extends PharmacistPredictState {}

class PharmacistPredictLoading extends PharmacistPredictState {}

class PharmacistPredictFailure extends PharmacistPredictState {
  final String errMessage;

  PharmacistPredictFailure({required this.errMessage});
}

class PharmacistPredictSuccess extends PharmacistPredictState {
  final List<PredictProductInfoModel> predictProducts;

  PharmacistPredictSuccess({required this.predictProducts});
}

class SearchQueryState extends PharmacistPredictState {
  final String search;

  SearchQueryState({required this.search});
}

class PharmacistDrugPredictionLoading extends PharmacistPredictState {}

class PharmacistDrugPredictionFailure extends PharmacistPredictState {
  final String errMessage;

  PharmacistDrugPredictionFailure({required this.errMessage});
}

class PharmacistDrugPredictionSuccess extends PharmacistPredictState {
  final DrugPredictionModel drugPrediction;

  PharmacistDrugPredictionSuccess({required this.drugPrediction});
}
