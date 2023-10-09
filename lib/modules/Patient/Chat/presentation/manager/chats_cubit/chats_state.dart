// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsFailure extends ChatsState {
  final String errMessage;

  ChatsFailure({required this.errMessage});
}

class ChatsSuccess extends ChatsState {
  final List<ChatModel> chats;
  ChatsSuccess({required this.chats});
}


class SearchQueryState extends ChatsState {
  final String search;

  SearchQueryState({required this.search});
}
