// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/modules/Patient/Chat/data/model/message_model.dart';

import '../../../../../core/utils/constants.dart';
import '../model/chat_model.dart';
import 'chat_repo.dart';

class ChatsRepoImpl implements ChatsRepo {
  ApiService apiService;
  ChatsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ChatModel>>> fetchChats() async {
    try {

      var data = await apiService.get(endPoint: 'chat/chats');
      List<ChatModel> chats = [];

      for (var item in data['mappedChats']) {
        chats.add(ChatModel.fromJson(item));
      }
      return right(chats);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> fetchChatDetails(
      {required String chatId}) async {
    try {
      String? senderId;
      if(appMode!.userType == 'patient') {
        senderId = mainPatient!.id;
      } else if(appMode!.userType == 'pharmacist') {
        senderId = mainPharmacist!.pharmacyId;
      }


      var data = await apiService.get(endPoint: 'chat/messages/$chatId/$senderId');

      List<MessageModel> chatDetails = [];

      for (var item in data['messagesShared']) {
        chatDetails.add(MessageModel.fromJson(item));
      }
      return right(chatDetails);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

}
