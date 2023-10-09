import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../data/model/chat_model.dart';
import '../../manager/chats_cubit/chats_cubit.dart';
import 'chat_item.dart';

class ChatsSection extends StatelessWidget {
  const ChatsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        if (state is ChatsSuccess || state is SearchQueryState) {
          if (BlocProvider.of<ChatsCubit>(context).chats.isNotEmpty) {
            final chatsCubit = BlocProvider.of<ChatsCubit>(context);
            final searchText =
                chatsCubit.searchChatController.text.toLowerCase();
            // ignore: prefer_function_declarations_over_variables
            bool Function(ChatModel) startsWith = (ChatModel search) {
              return search.listenerName
                      ?.toLowerCase()
                      .startsWith(searchText) ??
                  false;
            };
            List<ChatModel> filterList =
                chatsCubit.chats.where(startsWith).toList();

            if (filterList.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) =>
                    ChatItem(mappedChats: filterList[index]),
                itemCount: filterList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15.0),
              );
            } else {
              return const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          } else {
            return const CustomEmptyWidget(
              image: "assets/images/Empty_chat.png",
              title: 'No Chats Yet!',
              subTitle: 'Start chatting with pharmacists',
            );
          }
        } else if (state is ChatsFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else if (state is ChatsLoading) {
          return const CustomLoadingIndicator();
        }
        return Container();
      },
    );
  }
}
