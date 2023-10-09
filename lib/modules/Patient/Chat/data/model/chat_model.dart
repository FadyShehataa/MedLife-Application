class ChatModel {
  String? chatId;
  DateTime? updatedAt;
  String? listenerId;
  String? listenerName;
  String? listenerImage;

  ChatModel({
    this.chatId,
    this.updatedAt,
    this.listenerId,
    this.listenerName,
    this.listenerImage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatId: json['chatId'] as String?,
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        listenerId: json['listenerId'] as String?,
        listenerName: json['listenerName'] as String?,
        listenerImage: json['listenerImage'] == null ? '' : json['listenerImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'updatedAt': updatedAt?.toIso8601String(),
        'listenerId': listenerId,
        'listenerName': listenerName,
        'listenerImage': listenerImage,
      };
}
