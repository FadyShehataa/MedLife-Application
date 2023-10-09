import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/chat_model.dart';
import '../../manager/chat_details_cubit/chat_details_cubit.dart';
import '../../../../../../core/utils/components.dart';

import '../chat_detials_view.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.mappedChats}) : super(key: key);
  final ChatModel mappedChats;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {


        BlocProvider.of<ChatDetailsCubit>(context)
            .getInitialChatDetails(chatId: mappedChats.listenerId!);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatDetailsView(
              chatModel: mappedChats,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: CachedNetworkImage(
                        imageUrl: mappedChats.listenerImage!,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 8,
                        ),
                        // placeholder: (context, url) => const CustomLoadingIndicator(),
                      ),
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 30.0,
                  //
                  //   // backgroundImage:
                  //   //     NetworkImage(mappedChats.listenerImage!),
                  // ),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(
                      bottom: 3.0,
                      end: 3.0,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 7.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mappedChats.listenerName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    //  Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text(
                    //         'Last Sent Message',
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //     Column(
                    //       children: [
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         Text(
                    //           '02:00 pm',
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          separate(),
        ],
      ),
    );
  }
}
