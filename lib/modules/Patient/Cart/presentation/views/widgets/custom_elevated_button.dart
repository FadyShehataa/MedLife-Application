import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.child,
    this.onPressed,
    this.radius = 16,
    this.backgroundColor = MyColors.myBlue,
  }) : super(key: key);

  final Widget? child;
  final void Function()? onPressed;
  final double? radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius!),
              ),
            ),
            onPressed: onPressed,
            child: child,
          ),
        ),
      ],
    );
  }
}
