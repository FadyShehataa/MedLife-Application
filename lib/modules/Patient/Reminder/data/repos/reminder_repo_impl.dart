// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/modules/PATIENT/Reminder/data/model/reminder_model.dart';
import 'package:medlife_app/modules/PATIENT/Reminder/data/repos/reminder_repo.dart';

class ReminderRepoImpl extends ReminderRepo {
  ApiService apiService;
  ReminderRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ReminderModel>>> fetchReminder() async {
    try {
      var data = await apiService.get(endPoint: 'reminder/fetch');

      List<ReminderModel> reminders = [];

      for (var item in data['reminders']) {
        reminders.add(ReminderModel.fromJson(item));
      }
      return right(reminders);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReminderModel>> deleteReminder(
      {required String reminderId}) async {
    try {
      var data =
          await apiService.delete(endPoint: 'reminder/delete/$reminderId');

      ReminderModel reminder = ReminderModel.fromJson(data['reminder']);

      return right(reminder);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReminderModel>> addReminder(
      {dynamic bodyRequest}) async {
    try {
      var data = await apiService.post(
          endPoint: 'reminder/add', bodyRequest: bodyRequest);

      ReminderModel reminder = ReminderModel.fromJson(data['reminder']);

      return right(reminder);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
