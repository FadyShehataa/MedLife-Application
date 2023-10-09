import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    Key? key,
    required this.name,
    required this.phoneNumber,
  }) : super(key: key);

  final String name;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        Text(
          phoneNumber,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ],
    );
  }
}
