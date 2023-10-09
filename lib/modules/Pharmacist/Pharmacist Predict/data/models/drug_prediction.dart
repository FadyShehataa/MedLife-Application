// ignore_for_file: public_member_api_docs, sort_constructors_first
class DrugPredictionModel {
  final List<int> year;
  final List<int> month;
  final List<int> day;
  final List<int> drug;
  final List<int> predictedQuantity;

  DrugPredictionModel({
    required this.year,
    required this.month,
    required this.day,
    required this.drug,
    required this.predictedQuantity,
  });

  factory DrugPredictionModel.fromJson(Map<String, dynamic> json) {
    final year = List<int>.from(json['Year'].values);
    final month = List<int>.from(json['Month'].values);
    final day = List<int>.from(json['day'].values);
    final drug = List<int>.from(json['Drug'].values);
    final predictedQuantity = List<int>.from(json['predicted_quantity'].values);

    return DrugPredictionModel(
      year: year,
      month: month,
      day: day,
      drug: drug,
      predictedQuantity: predictedQuantity,
    );
  }

  @override
  String toString() {
    return 'DrugPredictionModel(year: $year, month: $month, day: $day, drug: $drug, predictedQuantity: $predictedQuantity)';
  }
}
