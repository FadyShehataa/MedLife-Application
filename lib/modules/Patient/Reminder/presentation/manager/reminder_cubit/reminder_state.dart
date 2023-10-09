part of 'reminder_cubit.dart';

@immutable
abstract class ReminderState {}

class ReminderInitial extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderFailure extends ReminderState {
  final String errMessage;

  ReminderFailure({required this.errMessage});
}

class ReminderSuccess extends ReminderState {
  final List<ReminderModel> reminders;

  ReminderSuccess({required this.reminders});
}
