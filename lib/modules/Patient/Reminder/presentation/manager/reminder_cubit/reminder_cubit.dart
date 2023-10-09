import 'package:bloc/bloc.dart';
import '../../../data/model/reminder_model.dart';
import '../../../data/repos/reminder_repo.dart';
import 'package:meta/meta.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit(this.reminderRepo) : super(ReminderInitial());

  final ReminderRepo reminderRepo;
  List<ReminderModel> reminders = [];

  DateTime selectedDate = DateTime.now();

  Future<void> fetchReminder() async {
    emit(ReminderLoading());

    var result = await reminderRepo.fetchReminder();

    result.fold(
      (failure) => emit(ReminderFailure(errMessage: failure.errMessage)),
      (reminders) {
        emit(ReminderSuccess(reminders: reminders));
        this.reminders = reminders;
      },
    );
  }

  Future<void> deleteReminder({required String reminderId}) async {
    // emit(ReminderLoading());

    var result = await reminderRepo.deleteReminder(reminderId: reminderId);

    result.fold(
      (failure) => emit(ReminderFailure(errMessage: failure.errMessage)),
      (reminder) {
        reminders =
            reminders.where((element) => element.id != reminder.id).toList();
        emit(ReminderSuccess(reminders: reminders));
      },
    );
  }

  Future<void> addReminder({dynamic bodyRequest}) async {
    // emit(ReminderLoading());

    var result = await reminderRepo.addReminder(bodyRequest: bodyRequest);

    result.fold(
      (failure) => emit(ReminderFailure(errMessage: failure.errMessage)),
      (reminder) {
        reminders.add(reminder);
        emit(ReminderSuccess(reminders: reminders));
      },
    );
  }

  Future<void> selectedDayQuery(DateTime query) async {
    emit(ReminderSuccess(reminders: reminders));
    selectedDate = query;
  }
}
