import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../Pharmacist%20Predict/data/models/drug_prediction.dart';
import '../../../Pharmacist%20Predict/data/models/predict_product_info_model.dart';

abstract class PharmacistPredictRepo {
  Future<Either<Failure, List<PredictProductInfoModel>>> fetchPredictProducts();

  Future<Either<Failure, DrugPredictionModel>> fetchDrugPrediction(
      {dynamic bodyRequest});
}
