// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/core/utils/service_locator.dart';

import '../Models/app_mode.dart';
import '../Models/new_patient.dart';
import '../Models/new_pharmacist.dart';
import '../errors/failures.dart';

class UpdateToken {
  Future<Either<Failure, void>> updateToken() async {
    try {
      var data =
          await getIt.get<ApiService>().post(endPoint: 'patient/token/refresh');

      Box box = await Hive.openBox('app');

      AppMode appMode = box.get('mode');

      if (appMode.userType == 'patient') {
        NewPatient patient = box.get('patient');
        patient.token = data['token']['id'];
        await patient.save();
      } else if (appMode.userType == 'pharmacist') {
        NewPharmacist pharmacist = box.get('pharmacist');
        pharmacist.token = data['token']['id'];
        await pharmacist.save();
      }

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
