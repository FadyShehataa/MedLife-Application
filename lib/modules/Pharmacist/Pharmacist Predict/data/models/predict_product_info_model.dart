class PredictProductInfoModel {
  String? name;
  int? number;

  PredictProductInfoModel({this.name, this.number});

  factory PredictProductInfoModel.fromJson(Map<String, dynamic> json) {
    return PredictProductInfoModel(
      name: json['name'] as String?,
      number: json['number'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'number': number,
      };
}
