// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_details_cubit.dart';

@immutable
abstract class ChatDetailsState {}

class ChatDetailsInitial extends ChatDetailsState {}

class ChatDetailsLoading extends ChatDetailsState {}

class ChatDetailsFailure extends ChatDetailsState {
  final String errMessage;

  ChatDetailsFailure({required this.errMessage});
}

class ChatDetailsSuccess extends ChatDetailsState {
  final List<MessageLiveModel> messages;
  ChatDetailsSuccess({required this.messages});
}
