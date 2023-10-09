import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 0),
        alignment: Alignment.center,
        child: EmptyWidget(
          image: image,
          title: title,
          subTitle: subTitle,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            color: MyColors.myBlue,
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: const TextStyle(
            fontSize: 14,
            color: MyColors.myBlue,
          ),
        ),
      ),
    );
  }
}
