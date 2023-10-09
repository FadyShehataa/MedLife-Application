import 'location.dart';

class Pharmacy {
  Location? location;
  String? id;
  String? admin;
  bool? isChattingAvailable;
  bool? isDeliveryAvailable;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? profileImageUrl;

  Pharmacy({
    this.location,
    this.id,
    this.admin,
    this.isChattingAvailable,
    this.isDeliveryAvailable,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profileImageUrl,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) => Pharmacy(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
        id: json['_id'] as String?,
        admin: json['admin'] as String?,
        isChattingAvailable: json['isChattingAvailable'] as bool?,
        isDeliveryAvailable: json['isDeliveryAvailable'] as bool?,
        name: json['name'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        profileImageUrl: json['profileImageURL'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        '_id': id,
        'admin': admin,
        'isChattingAvailable': isChattingAvailable,
        'isDeliveryAvailable': isDeliveryAvailable,
        'name': name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'profileImageURL': profileImageUrl,
      };
}
