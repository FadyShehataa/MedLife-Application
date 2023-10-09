class ReminderModel {
  String? id;
  String? patientId;
  String? reminderName;
  String? productName;
  DateTime? startDate;
  DateTime? endDate;
  String? reminderTime;
  bool? daily;
  List<String>? specificDays;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ReminderModel({
    this.id,
    this.patientId,
    this.reminderName,
    this.productName,
    this.startDate,
    this.endDate,
    this.reminderTime,
    this.daily,
    this.specificDays,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        id: json['_id'] as String?,
        patientId: json['patientId'] as String?,
        reminderName: json['reminderName'] as String?,
        productName: json['productName'] as String?,
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null
            ? null
            : DateTime.parse(json['endDate'] as String),
        reminderTime: json['reminderTime'] as String?,
        daily: json['daily'] as bool?,
        specificDays: (json['specificDays'] as List<dynamic>?)?.cast<String>(),
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
        'patientId': patientId,
        'reminderName': reminderName,
        'productName': productName,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'reminderTime': reminderTime,
        'daily': daily,
        'specificDays': specificDays,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
