import 'package:flutter/material.dart';
import '../../../../../../main.dart';

import '../../../../../../core/utils/constants.dart';

class PatientActivityItem extends StatelessWidget {
  const PatientActivityItem({
    Key? key,
    this.onTap,
    this.icon,
    this.trailing,
    required this.height,
    required this.text,
    required this.width,
  }) : super(key: key);

  final void Function()? onTap;
  final IconData? icon;
  final IconData? trailing;
  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: !MyApp.isMobile ? height * .05 : null,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: MyApp.isMobile ? 35 : 60,
          height: MyApp.isMobile ? 35 : 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blueGrey.withOpacity(0.2),
          ),
          child: Icon(
            icon,
            color: MyColors.myBlue, //Colors.blue,
            size: !MyApp.isMobile ? 40 : null,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: !MyApp.isMobile ? width * 0.03 : 18),
        ),
        trailing: Icon(
          trailing,
          color: MyColors.myBlue.withOpacity(0.8), //Colors.blue.withOpacity(0.8),
          size: !MyApp.isMobile ? 40 : null,
        ),
      ),
    );
  }
}
