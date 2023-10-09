import 'package:flutter/material.dart';

class BubbleChatForFriend extends StatelessWidget {
  const BubbleChatForFriend({Key? key, required this.message})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: (Text(
          message,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        )),
      ),
    );
  }
}
