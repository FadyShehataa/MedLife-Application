import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../../../main.dart';
import '../../../data/model/reminder_model.dart';
import '../../manager/reminder_cubit/reminder_cubit.dart';
import 'reminder_item.dart';
import '../../../../../../core/utils/constants.dart';

class ReminderTodayActivitiesSection extends StatelessWidget {
  const ReminderTodayActivitiesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Today Activities',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MyApp.isMobile ? 24 : 40,
                color: MyColors.myBlack,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            // width: double.infinity,
            // height: 100.0,
            child: BlocBuilder<ReminderCubit, ReminderState>(
              builder: ((context, state) {
                if (state is ReminderSuccess) {
                  List<ReminderModel> filterList =
                      state.reminders.where((element) {
                    return element.startDate!.isBefore(
                            BlocProvider.of<ReminderCubit>(context)
                                .selectedDate) &&
                        element.endDate!.isAfter(
                            BlocProvider.of<ReminderCubit>(context)
                                .selectedDate);
                  }).toList();
                  if (filterList.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filterList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) async {
                            BlocProvider.of<ReminderCubit>(context)
                                .deleteReminder(
                                    reminderId: filterList[index].id!);
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: MyColors.myRed,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: Icon(
                                  Icons.delete,
                                  color: MyColors.myWhite,
                                  size: MyApp.isMobile ? 30 : 50,
                                ),
                              ),
                            ),
                          ),
                          child: ReminderItem(
                            reminderModel: filterList[index],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Not Reminders'),
                    );
                  }
                } else if (state is ReminderFailure) {
                  return CustomErrorWidget(errMessage: state.errMessage);
                } else if (state is ReminderLoading) {
                  return const CustomLoadingIndicator();
                }
                return Container();
              }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
