import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/repos/chat_repo.dart';

import '../../../data/model/chat_model.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.chatsRepo) : super(ChatsInitial());

  final ChatsRepo chatsRepo;
  List<ChatModel> chats = [];
  TextEditingController searchChatController = TextEditingController();

  Future<void> searchChatQuery(String query) async {
    emit(SearchQueryState(search: query));
    searchChatController.text = query;
  }

  Future<void> fetchChats() async {
    emit(ChatsLoading());
    var result = await chatsRepo.fetchChats();

    result.fold(
      (failure) => emit(ChatsFailure(errMessage: failure.errMessage)),
      (chats) {
        emit(ChatsSuccess(chats: chats));
        this.chats = chats;
      },
    );
  }
}
