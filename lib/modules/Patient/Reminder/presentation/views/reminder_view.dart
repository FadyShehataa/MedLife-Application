import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../main.dart';
import '../manager/reminder_cubit/reminder_cubit.dart';
import 'add_reminder_screen.dart';
import 'widgets/reminder_view_body.dart';

import '../../../../../core/utils/constants.dart';

class ReminderView extends StatefulWidget {
  const ReminderView({Key? key}) : super(key: key);

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  @override
  void initState() {
    super.initState();
    fetchReminder();
  }

  Future<void> fetchReminder() async {
    BlocProvider.of<ReminderCubit>(context).fetchReminder();
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ReminderViewBody(screenH: screenH, screenW: screenW),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.myBlue,
        child: Icon(
          Icons.add,
          size: MyApp.isMobile ? 24 : 32,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const AddReminderScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
