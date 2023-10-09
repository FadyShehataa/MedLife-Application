import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../model/message_model.dart';

import '../model/chat_model.dart';

abstract class ChatsRepo {
  Future<Either<Failure, List<ChatModel>>> fetchChats();

  Future<Either<Failure, List<MessageModel>>> fetchChatDetails(
      {required String chatId});
}
