import 'package:flutter/material.dart';

import '../../../../../core/utils/constants.dart';

class CustomAuthTextButton extends StatelessWidget {
  const CustomAuthTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isMobile,
    required this.width,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final bool isMobile;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: MyColors.myBlue,//Colors.blue,
          fontSize: isMobile ? 17 : width * 0.0253,
        ),
      ),
    );
  }
}
