import 'package:flutter/material.dart';
import 'reminder_calendar_section.dart';
import 'reminder_image_section.dart';
import 'reminder_today_activities_section.dart';

class ReminderViewBody extends StatelessWidget {
  const ReminderViewBody({
    Key? key,
    required this.screenH,
    required this.screenW,
  }) : super(key: key);

  final double screenH;
  final double screenW;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Column(
        children: [
          const ReminderImageSection(),
          ReminderCalendarSection(screenH: screenH, screenW: screenW),
          const SizedBox(height: 20),
          const Expanded(
            child: ReminderTodayActivitiesSection(),
          ),
        ],
      ),
    );
  }
}
