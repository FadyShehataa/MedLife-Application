class MessageModel {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MessageModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['_id'] as String?,
        senderId: json['senderId'] as String?,
        receiverId: json['receiverId'] as String?,
        message: json['message'] as String?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'date': date?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
