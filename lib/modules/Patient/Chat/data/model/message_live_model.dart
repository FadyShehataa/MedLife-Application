// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageLiveModel {
  String? message;
  String? sentBy;
  String? receiverID;

  MessageLiveModel({
    this.message,
    this.sentBy,
    this.receiverID,
  });

  factory MessageLiveModel.fromJson(Map<String, dynamic> json) =>
      MessageLiveModel(
        message: json['message'] as String?,
        sentBy: json['sentBy'] as String?,
        receiverID: json['receiverID'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'sentBy': sentBy,
        'receiverID': receiverID,
      };
}
