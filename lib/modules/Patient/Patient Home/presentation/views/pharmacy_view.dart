import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Patient%20Home/data/models/pharmacy_model/pharmacy_model.dart';
import '../../../Patient%20Home/presentation/manager/categories_cubit/categories_cubit.dart';
import '../../../Patient%20Home/presentation/views/widgets/pharmacy_view_body.dart';

import '../../../Chat/data/model/chat_model.dart';
import '../../../Chat/presentation/manager/chat_details_cubit/chat_details_cubit.dart';
import '../../../Chat/presentation/manager/chats_cubit/chats_cubit.dart';
import '../../../Chat/presentation/views/chat_detials_view.dart';

class PharmacyView extends StatefulWidget {
  PharmacyView({Key? key, required this.pharmacy}) : super(key: key);

  final PharmacyModel pharmacy;

  ChatModel Chatmodel = ChatModel();

  @override
  State<PharmacyView> createState() => _PharmacyViewState();
}

class _PharmacyViewState extends State<PharmacyView> {
  Future<ChatModel> fetchChatModel(String? pharmacyId) async {
    //1 Fetch Chats
    await BlocProvider.of<ChatsCubit>(context).fetchChats();

    //2 Find ChatModel matching PharmacyId
    List<ChatModel> chatList = BlocProvider.of<ChatsCubit>(context).chats;
    for (ChatModel chat in chatList) {
      if (chat.listenerId == pharmacyId) {
        return chat;
      }
    }

    //3 If not found Create New ChatModel
    return ChatModel(
        listenerId: widget.pharmacy.id, listenerName: widget.pharmacy.name);
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    await BlocProvider.of<CategoriesCubit>(context).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: PharmacyViewBody(pharmacy: widget.pharmacy),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              ChatModel pharmacyChatModel =
                  await fetchChatModel(widget.pharmacy.id);

              BlocProvider.of<ChatDetailsCubit>(context)
                  .getInitialChatDetails(chatId: pharmacyChatModel.listenerId!);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ChatDetailsView(chatModel: pharmacyChatModel)));
            },
            child: const Icon(Icons.chat)));
  }
}
