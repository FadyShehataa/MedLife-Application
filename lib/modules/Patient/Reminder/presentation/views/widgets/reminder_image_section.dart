import 'package:flutter/material.dart';

class ReminderImageSection extends StatelessWidget {
  const ReminderImageSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 6 / 2.5,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/pills.png'),
            ),
          ),
        ),
      ),
    );
  }
}
