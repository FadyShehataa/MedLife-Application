import 'item.dart';
import 'purchaser.dart';

class PharmacistOrderModel {
  Purchaser? purchaser;
  String? id;
  List<Item>? items;
  String? status;
  String? receiver;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? note;
  int? totalPrice;

  PharmacistOrderModel({
    this.purchaser,
    this.id,
    this.items,
    this.status,
    this.receiver,
    this.createdAt,
    this.updatedAt,
    this.note,
    this.totalPrice,
  });

  factory PharmacistOrderModel.fromJson(Map<String, dynamic> json) {
    return PharmacistOrderModel(
      purchaser: json['purchaser'] == null
          ? null
          : Purchaser.fromJson(json['purchaser'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      receiver: json['receiver'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      note: json['note'] as String?,
      totalPrice: json['totalPrice'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'purchaser': purchaser?.toJson(),
        '_id': id,
        'items': items?.map((e) => e.toJson()).toList(),
        'status': status,
        'receiver': receiver,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'note': note,
        'totalPrice': totalPrice,
      };
}
