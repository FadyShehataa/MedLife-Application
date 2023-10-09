import 'image.dart';
import 'pharmacy.dart';

class Product {
  String? id;
  String? name;
  String? barcode;
  String? type;
  List<String>? categories;
  List<Image>? images;
  List<String>? description;
  List<dynamic>? indication;
  List<dynamic>? sideEffects;
  List<dynamic>? dosage;
  List<dynamic>? overdoseEffects;
  List<dynamic>? precautions;
  List<dynamic>? interactions;
  List<dynamic>? storage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Pharmacy? pharmacy;

  Product({
    this.id,
    this.name,
    this.barcode,
    this.type,
    this.categories,
    this.images,
    this.description,
    this.indication,
    this.sideEffects,
    this.dosage,
    this.overdoseEffects,
    this.precautions,
    this.interactions,
    this.storage,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.pharmacy,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        barcode: json['barcode'] as String?,
        type: json['type'] as String?,
        categories: (json['categories'] as List<dynamic>?)?.cast<String>(),
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        description: (json['description'] as List<dynamic>?)?.cast<String>(),
        indication: json['indication'] as List<dynamic>?,
        sideEffects: json['sideEffects'] as List<dynamic>?,
        dosage: json['dosage'] as List<dynamic>?,
        overdoseEffects: json['overdoseEffects'] as List<dynamic>?,
        precautions: json['precautions'] as List<dynamic>?,
        interactions: json['interactions'] as List<dynamic>?,
        storage: json['storage'] as List<dynamic>?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        pharmacy: json['pharmacy'] == null
            ? null
            : Pharmacy.fromJson(json['pharmacy'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'barcode': barcode,
        'type': type,
        'categories': categories,
        'images': images?.map((e) => e.toJson()).toList(),
        'description': description,
        'indication': indication,
        'sideEffects': sideEffects,
        'dosage': dosage,
        'overdoseEffects': overdoseEffects,
        'precautions': precautions,
        'interactions': interactions,
        'storage': storage,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'pharmacy': pharmacy?.toJson(),
      };
}
