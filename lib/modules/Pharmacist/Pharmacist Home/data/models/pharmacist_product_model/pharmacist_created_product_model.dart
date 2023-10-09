import 'product.dart';

class CreatedPharmacistProductModel {
  Product? product;
  String? pharmacy;
  int? amount;
  int? price;
  String? offer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CreatedPharmacistProductModel({
    this.product,
    this.pharmacy,
    this.amount,
    this.price,
    this.offer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CreatedPharmacistProductModel.fromJson(Map<String, dynamic> json) {
    return CreatedPharmacistProductModel(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      pharmacy: json['pharmacy'] as String?,
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
    'product': product?.toJson(),
    'pharmacy': pharmacy,
    'amount': amount,
    'price': price,
    'offer': offer,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
