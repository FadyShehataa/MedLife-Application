class PharmacistOrderConfirmModel {
  String? message;

  PharmacistOrderConfirmModel({this.message});

  factory PharmacistOrderConfirmModel.fromJson(Map<String, dynamic> json) {
    return PharmacistOrderConfirmModel(
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
