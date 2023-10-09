import 'package:flutter/material.dart';

import '../../../data/models/boarding_model.dart';

class BoardingItem extends StatelessWidget {
  const BoardingItem({Key? key, required this.model}) : super(key: key);
  final BoardingModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: SizedBox(child: Image(image: AssetImage(model.image)))),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15.0),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50.0),
      ],
    );
  }
}
