import 'package:flutter/material.dart';
import '../../../../../../main.dart';
import '../../../data/model/reminder_model.dart';
import '../../../../../../core/utils/constants.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem({
    Key? key,
    required this.reminderModel,
  }) : super(key: key);

  final ReminderModel reminderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: MyColors.myGrey.withOpacity(0.4),
        ),
        child: ListTile(
          title: Text(
            reminderModel.reminderName!,
            style: TextStyle(fontSize: MyApp.isMobile ? 16 : 30),
          ),
          subtitle: Text(
            reminderModel.productName!,
            style: TextStyle(
                color: MyColors.myGrey, fontSize: MyApp.isMobile ? 16 : 30),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.myWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              reminderModel.reminderTime!,
              style: TextStyle(fontSize: MyApp.isMobile ? 18 : 30),
            ),
          ),
          selectedTileColor: MyColors.myGrey.withOpacity(0.4),
          selectedColor: MyColors.myGrey.withOpacity(0.4),
        ),
      ),
    );
  }
}
