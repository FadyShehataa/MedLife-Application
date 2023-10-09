import 'package:bloc/bloc.dart';
import '../../../data/model/message_live_model.dart';
import '../../../data/repos/chat_repo.dart';
import '../../../../../../core/utils/Controllers/Chat/SocketConnection.dart';
import 'package:meta/meta.dart';

part 'chat_details_state.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsState> {
  ChatDetailsCubit(this.chatsRepo) : super(ChatDetailsInitial());

  SocketConnection socketConnection = SocketConnection.getObj();


  final ChatsRepo chatsRepo;

  List<MessageLiveModel> messages = [];

  void sendMessage(String text, String senderId, String receiverId) {
    Map<String, String> data =
        socketConnection.sendMessage(text, senderId, receiverId);

    MessageLiveModel message = MessageLiveModel.fromJson(data);
    messages.add(message);
    emit(ChatDetailsSuccess(messages: messages));
  }

  void getMessages() {
    var socket = socketConnection.getSocket();

    socket.on('message_receive', (data) {
      MessageLiveModel message = MessageLiveModel.fromJson(data);
      messages.add(message);
      emit(ChatDetailsSuccess(messages: messages));
    });
  }


  void getInitialChatDetails({required String chatId}) async {
    emit(ChatDetailsLoading());

    messages = [];

    var result = await chatsRepo.fetchChatDetails(chatId: chatId);

    result.fold(
      (failure) => emit(ChatDetailsFailure(errMessage: failure.errMessage)),
      (chatInitialDetails) {
        for (int i = 0; i < chatInitialDetails.length; i++) {
          var data = {
            "message": chatInitialDetails[i].message,
            "sentBy": chatInitialDetails[i].senderId,
            "receiverID": chatInitialDetails[i].receiverId,
          };
          MessageLiveModel message = MessageLiveModel.fromJson(data);
          messages.add(message);
        }
        emit(ChatDetailsSuccess(messages: messages));
      },
    );
  }
}
