// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'location.dart';

class PharmacyModel {
  Location? location;
  bool? isChattingAvailable;
  bool? isDeliveryAvailable;
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? rating; 
  String? pharmacistImage;

  PharmacyModel({
    this.location,
    this.isChattingAvailable,
    this.isDeliveryAvailable,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.rating,
    this.pharmacistImage,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) => PharmacyModel(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location']),
        isChattingAvailable: json['isChattingAvailable'] as bool?,
        isDeliveryAvailable: json['isDeliveryAvailable'] as bool?,
        id: json['_id'] as String?,
        name: json['name'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        rating: json['rating'] is int
            ? (json['rating'] as int).toDouble()
            : json['rating'] as double?,
        pharmacistImage: json['pharmacistImage'] == null ? null : json['pharmacistImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'isChattingAvailable': isChattingAvailable,
        'isDeliveryAvailable': isDeliveryAvailable,
        '_id': id,
        'name': name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'rating': rating,

        'pharmacistImage': pharmacistImage,
      };

  @override
  String toString() {
    return 'PharmacyModel(location: $location, isChattingAvailable: $isChattingAvailable, isDeliveryAvailable: $isDeliveryAvailable, id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, rating: $rating, pharmacistImage: $pharmacistImage)';
  }
}
