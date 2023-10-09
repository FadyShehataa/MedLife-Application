import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_search.dart';
import '../../manager/chats_cubit/chats_cubit.dart';

class ChatSearchSection extends StatelessWidget {
  ChatSearchSection({Key? key}) : super(key: key);

  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CustomSearch(
        readonly: false,
        autofocus: false,
        controller: chatController,
        hintText: 'Search message',
        suffixIconButton: IconButton(
          onPressed: () {
            BlocProvider.of<ChatsCubit>(context)
                .searchChatQuery(chatController.text);
          },
          icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
        ),
        onSubmitted: (_) {
          BlocProvider.of<ChatsCubit>(context)
              .searchChatQuery(chatController.text);
        },
      ),
    );
  }
}
