import 'product.dart';

class PrescriptionModel {
  String? id;
  Product? product;
  int? amount;
  int? price;
  String? offer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PrescriptionModel({
    this.id,
    this.product,
    this.amount,
    this.price,
    this.offer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['_id'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      amount: json['amount'] as int?,
      price: json['price'] as int?,
      offer: json['offer'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'product': product?.toJson(),
        'amount': amount,
        'price': price,
        'offer': offer,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
