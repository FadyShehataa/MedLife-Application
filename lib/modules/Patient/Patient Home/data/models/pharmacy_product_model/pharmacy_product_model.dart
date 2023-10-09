// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'product.dart';

class PharmacyProductModel {
  String? id;
  Product? product;
  String? pharmacy;
  int? amount;
  int? price;
  String? offer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PharmacyProductModel({
    this.id,
    this.product,
    this.pharmacy,
    this.amount,
    this.price,
    this.offer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PharmacyProductModel.fromJson(Map<String, dynamic> json) {
    return PharmacyProductModel(
      id: json['_id'] as String?,
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
        '_id': id,
        'product': product?.toJson(),
        'pharmacy': pharmacy,
        'amount': amount,
        'price': price,
        'offer': offer,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  @override
  String toString() {
    return 'PharmacyProductModel(id: $id, product: $product, pharmacy: $pharmacy, amount: $amount, price: $price, offer: $offer, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }
}
