import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../main.dart';
import '../../manager/reminder_cubit/reminder_cubit.dart';
import '../../../../../../core/utils/constants.dart';

class ReminderCalendarSection extends StatelessWidget {
  const ReminderCalendarSection({
    Key? key,
    required this.screenH,
    required this.screenW,
  }) : super(key: key);

  final double screenH;
  final double screenW;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Reminder',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MyApp.isMobile ? 24 : 40,
                color: MyColors.myBlack,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<ReminderCubit, ReminderState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: DatePicker(
                  DateTime.now(),
                  height: screenH * 0.127,
                  width: screenW * 0.18,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: MyColors.myBlue,
                  selectedTextColor: MyColors.myWhite,
                  dayTextStyle: GoogleFonts.bitter(
                    fontSize: MyApp.isMobile ? 12 : 30,
                    fontWeight: FontWeight.w500,
                  ),
                  monthTextStyle: GoogleFonts.bitter(
                    fontSize: MyApp.isMobile ? 12 : 30,
                    fontWeight: FontWeight.w500,
                  ),
                  dateTextStyle: GoogleFonts.bitter(
                    fontSize: MyApp.isMobile ? 12 : 34,
                    fontWeight: FontWeight.w500,
                  ),
                  onDateChange: (date) {
                    BlocProvider.of<ReminderCubit>(context)
                        .selectedDayQuery(date);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
