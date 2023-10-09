import 'package:flutter/material.dart';

class SeparateWidget extends StatelessWidget {
  const SeparateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.grey.withOpacity(0.5),
      height: 1,
      width: double.infinity,
    );
  }
}
