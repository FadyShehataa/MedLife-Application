import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/chats_cubit/chats_cubit.dart';
import 'widgets/chat_view_body.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  State<ChatsView> createState() => _ChatsViewState();
}



class _ChatsViewState extends State<ChatsView> {

  @override
  void initState() {
    super.initState();
    fetchChats();
  }

  Future<void> fetchChats() async {
    await BlocProvider.of<ChatsCubit>(context).fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ChatViewBody(),
      ),
    );
  }
}
