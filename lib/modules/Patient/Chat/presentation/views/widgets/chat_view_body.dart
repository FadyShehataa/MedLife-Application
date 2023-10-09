import 'package:flutter/material.dart';
import 'chat_search_section.dart';
import 'chats_section.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            ChatSearchSection(),
            const SizedBox(height: 20.0),
            const Expanded(
              child: ChatsSection(),
            )
          ],
        ),
      ),
    );
  }
}
