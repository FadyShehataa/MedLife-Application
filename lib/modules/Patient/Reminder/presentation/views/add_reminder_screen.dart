import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../main.dart';
import 'widgets/reminder_input_field.dart';
import '../../../../../core/utils/constants.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../manager/reminder_cubit/reminder_cubit.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  FocusNode productNode = FocusNode();
  late TextEditingController productController = TextEditingController();
  FocusNode reminderNode = FocusNode();
  late TextEditingController reminderController = TextEditingController();

  FocusNode taskBodyNode = FocusNode();
  late TextEditingController taskBodyController = TextEditingController();

  FocusNode beginDateNode = FocusNode();
  FocusNode finishDateNode = FocusNode();
  TextEditingController beginDateController = TextEditingController();
  TextEditingController finishDateController = TextEditingController();
  DateTime beginDate = DateTime.now();
  DateTime finishDate = DateTime.now();
  final String _beginDate = DateFormat.yMd().format(DateTime.now());
  final String _finishDate = DateFormat.yMd().format(DateTime.now());

  bool everyDay = false;
  late List<bool> values = List.filled(7, false);

  FocusNode startTimeNode = FocusNode();
  TextEditingController startTimeController = TextEditingController();
  FocusNode remindNode = FocusNode();
  TextEditingController remindController = TextEditingController();

  final String _currentTime = DateFormat('hh:mm a').format(DateTime.now());
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MyApp.isMobile;
    final double scale = isMobile ? 1 : 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reminder'),
        backgroundColor: MyColors.myBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReminderInputField(
                  scale: scale,
                  textValueController: reminderController,
                  node: reminderNode,
                  label: 'Reminder Name',
                  hint: 'Add Reminder Name',
                  suffixIcon: const SizedBox(
                    height: 0.0,
                    width: 0.0,
                  ),
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "Don't forget to add Reminder Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ReminderInputField(
                  scale: scale,
                  textValueController: productController,
                  node: productNode,
                  label: 'Product Name',
                  hint: 'Add Product Name',
                  suffixIcon: const SizedBox(
                    height: 0.0,
                    width: 0.0,
                  ),
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "Don't forget to add Product Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ReminderInputField(
                  scale: scale,
                  textValueController: startTimeController,
                  node: startTimeNode,
                  label: 'Time',
                  hint: _currentTime,
                  suffixIcon: const Icon(
                    Icons.watch_later_outlined,
                    color: MyColors.myBlue,
                  ),
                  onSuffixTap: () {
                    _getTime();
                  },
                  onValidate: (value) {
                    if (value.isEmpty) {
                      return "Don't forget to add Time";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ReminderInputField(
                        scale: scale,
                        textValueController: beginDateController,
                        node: beginDateNode,
                        label: 'Begin',
                        hint: _beginDate,
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: MyColors.myBlue,
                        ),
                        onSuffixTap: () {
                          _getBeginDate();
                        },
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return "Add Begin Date";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: ReminderInputField(
                        scale: scale,
                        textValueController: finishDateController,
                        node: finishDateNode,
                        label: 'Finish',
                        hint: _finishDate,
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: MyColors.myBlue,
                        ),
                        onSuffixTap: () {
                          _getFinishDate();
                        },
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return "Add Finish Date";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 18 * scale,
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: WeekdaySelector(
                    selectedElevation: 5,
                    selectedFillColor: MyColors.myBlue,
                    selectedColor: Colors.white,
                    weekdays: const [
                      'Sunday',
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday',
                    ],
                    shortWeekdays: const [
                      'Sun',
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                    ],
                    onChanged: (int day) {
                      setState(() {
                        final index = day % 7;
                        values[index] = !values[index];
                      });
                    },
                    values: values,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            List<String> days = const [
                              'Sunday',
                              'Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday',
                              'Saturday',
                            ];

                            List<String> trueDays = days
                                .where((day) => values[days.indexOf(day)])
                                .toList();

                            DateFormat inputFormat = DateFormat("M/d/y h:mm a");

                            DateFormat outputFormat =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

                            //split 1:01 and subtract one hour from first part
                            DateTime parsedStartDate = inputFormat.parse(
                                '${beginDateController.text} ${startTimeController.text}');
                            DateTime utcStartDate = parsedStartDate.toUtc();

                            Duration oneHour = Duration(hours: 1);
                            DateTime subtractedTime = utcStartDate.subtract(oneHour);

                            String formattedStartDate =
                                outputFormat.format(subtractedTime);

                            DateTime parsedEndDate = inputFormat.parse(
                                '${finishDateController.text} ${startTimeController.text}');
                            DateTime utcEndDate = parsedEndDate.toUtc();

                            DateTime subtractedEndTime = utcEndDate.subtract(oneHour);

                            String formattedEndDate =
                                outputFormat.format(subtractedEndTime);

                            BlocProvider.of<ReminderCubit>(context)
                                .addReminder(bodyRequest: {
                              "reminderName": reminderController.text,
                              "productName": productController.text,
                              "startDate": formattedStartDate,
                              "endDate": formattedEndDate,
                              "reminderTime": startTimeController.text,
                              "daily": "no",
                              "specificDays": trueDays
                            });

                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.myBlue,
                          padding: const EdgeInsets.all(20.0),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 22 * scale),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getBeginDate() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickerDate != null) {
      setState(() {
        beginDate = pickerDate;
        beginDateController.text = DateFormat.yMd().format(beginDate);
      });
    }
  }

  _getFinishDate() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: beginDate,
      firstDate: beginDate,
      lastDate: DateTime(2025),
    );
    if (pickerDate != null) {
      setState(() {
        finishDate = pickerDate;
        finishDateController.text = DateFormat.yMd().format(finishDate);
      });
    }
  }

  _getTime() async {
    var selectedTime = await _showTimePicker();
    String timeFormat = await selectedTime.format(context);
    if (timeFormat.isEmpty) {
    } else {
      setState(() {
        startTimeController.text = timeFormat;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_currentTime.split(':')[0]),
        minute: int.parse(_currentTime.split(':')[0].split(' ')[0]),
      ),
    );
  }
}
