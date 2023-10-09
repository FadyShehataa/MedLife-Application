import 'product.dart';

class Item {
  String? id;
  Product? product;
  String? pharmacy;
  int? amount;
  int? price;
  String? offer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? pharmacyName;
  int? quantity;

  Item({
    this.id,
    this.product,
    this.pharmacy,
    this.amount,
    this.price,
    this.offer,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.pharmacyName,
    this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
        pharmacyName: json['pharmacyName'] as String?,
        quantity: json['quantity'] as int?,
      );

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
        'pharmacyName': pharmacyName,
        'quantity': quantity,
      };
}
