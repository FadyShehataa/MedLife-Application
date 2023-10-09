import 'package:dartz/dartz.dart';
import '../model/reminder_model.dart';

import '../../../../../core/errors/failures.dart';

abstract class ReminderRepo {
  Future<Either<Failure, List<ReminderModel>>> fetchReminder();

  Future<Either<Failure, ReminderModel>> deleteReminder(
      {required String reminderId});

  Future<Either<Failure, ReminderModel>> addReminder({dynamic bodyRequest});
}
