import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';
import '../../data/model/chat_model.dart';
import '../manager/chat_details_cubit/chat_details_cubit.dart';
import 'widgets/bubble_chat.dart';
import 'widgets/bubble_chat_for_friend.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/constants.dart';

class ChatDetailsView extends StatefulWidget {
  ChatDetailsView({Key? key, required this.chatModel}) : super(key: key);
  var senderId;

  final ChatModel chatModel;

  @override
  State<ChatDetailsView> createState() => _chatState();
}

class _chatState extends State<ChatDetailsView> {
  TextEditingController msgController = TextEditingController();
  bool isLoading = true;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getId();
  }

  Future<void> getId() async {
    var senderId;
    if(appMode!.userType == "patient")
      senderId = mainPatient!.id;
    else if(appMode!.userType == "pharmacist")
      senderId = mainPharmacist!.pharmacyId;


    setState(() {
      widget.senderId = senderId;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CustomLoadingIndicator();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.chatModel.listenerName!,
            style: const TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[100],
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRect(
                  child: BlocBuilder<ChatDetailsCubit, ChatDetailsState>(
                    builder: (context, state) {
                      if (state is ChatDetailsSuccess) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          controller: _controller,
                          reverse: true,
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            int reversedIndex =
                                state.messages.length - index - 1;
                            return Container(
                              margin: EdgeInsets.only(top: 8.sp),
                              child: Column(
                                children: [
                                  state.messages[reversedIndex].sentBy ==
                                          widget.senderId
                                      ? BubbleChat(
                                          message: state
                                              .messages[reversedIndex].message!,
                                        )
                                      : BubbleChatForFriend(
                                          message: state
                                              .messages[reversedIndex].message!,
                                        ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 7.h,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: msgController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type here...',
                              hintStyle: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            onSubmitted: (_) {
                              if (msgController.text.trim().isNotEmpty) {
                                BlocProvider.of<ChatDetailsCubit>(context)
                                    .sendMessage(
                                        msgController.text.trim(),
                                        widget.senderId,
                                        widget.chatModel.listenerId!);
                                msgController.clear();
                                _controller.animateTo(0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (msgController.text.trim().isNotEmpty) {
                              BlocProvider.of<ChatDetailsCubit>(context)
                                  .sendMessage(
                                      msgController.text.trim(),
                                      widget.senderId,
                                      widget.chatModel.listenerId!);
                              msgController.clear();
                              _controller.animateTo(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            backgroundColor: MyColors.myBlue, //Colors.blue,
                          ),
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
