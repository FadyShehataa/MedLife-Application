// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/core/utils/update_token.dart';
import 'package:medlife_app/modules/Resignation/data/repos/auth_repo.dart';
import 'package:medlife_app/core/utils/Controllers/Chat/SocketConnection.dart';
import 'package:medlife_app/core/utils/Controllers/Notification/NotificationController.dart';
import 'package:medlife_app/core/utils/constants.dart';
import 'package:path/path.dart' as path;

import '../../../../core/Models/app_mode.dart';
import '../../../../core/Models/new_patient.dart';
import '../../../../core/Models/new_pharmacist.dart';


class AuthRepoImpl implements AuthRepo {
  ApiService apiService;
  AuthRepoImpl(this.apiService);
  SocketConnection socketConnection = SocketConnection.getObj();

  @override
  Future<Either<Failure, void>> loginPatient({bodyRequest}) async {
    try {
      var data = await apiService.post(
        endPoint: "patient/login",
        bodyRequest: bodyRequest,
      );

      if (data['patient'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      //Set TimeOut 2 hours for refresh token

      Timer.periodic(const Duration(seconds: 7200), refreshToken);

      //Initalize Notification Token
      CustomNotification notification = CustomNotification();
      notification.storeTokenOnUserLogin(data['patient']['_id']);

      Box box = await Hive.openBox('app');

      AppMode tempMode = await box.get('mode');
      tempMode.userType = 'patient';

      NewPatient newPatient = box.get('patient');
      newPatient.name = data['patient']['name'];
      newPatient.token = data['token']['id'];
      newPatient.id = data['patient']['_id'];
      newPatient.phoneNumber = data['patient']['phoneNumber'];

      if (data['patient']['profileImage'] != null) {
        newPatient.imageURL = data['patient']['profileImage'];
      } else {
        newPatient.imageURL = '';
      }
      await newPatient.save();

      mainPatient = await box.get('patient');
      await tempMode.save();
      appMode = await box.get('mode');

      //Initalize Socket Connection
      await socketConnection.initSocket();

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> loginPharmacist({bodyRequest}) async {
    try {
      var data = await apiService.post(
        endPoint: "pharmacist/login",
        bodyRequest: bodyRequest,
      );

      if (data['pharmacist'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      Timer.periodic(const Duration(seconds: 7200), refreshToken);

      //Initalize Notification Token
      CustomNotification notification = CustomNotification();
      notification.storeTokenOnUserLogin(data['pharmacist']['_id']);

      Box box = await Hive.openBox('app');
      AppMode tempMode = await box.get('mode');
      tempMode.userType = 'pharmacist';
      await tempMode.save();

      NewPharmacist newPharmacist = box.get('pharmacist');
      newPharmacist.name = data['pharmacist']['name'];
      newPharmacist.token = data['token']['id'];
      newPharmacist.id = data['pharmacist']['_id'];
      newPharmacist.email = data['pharmacist']['email'];
      newPharmacist.pharmacyId = data['pharmacist']['pharmacy']['_id'];
      newPharmacist.pharmacyName = data['pharmacist']['pharmacy']['name'];
      newPharmacist.lat =
          data['pharmacist']['pharmacy']['location']['lat'] is int
              ? (data['pharmacist']['pharmacy']['location']['lat'] as int)
                  .toDouble()
              : (data['pharmacist']['pharmacy']['location']['lat']) as double;
      newPharmacist.lng =
          data['pharmacist']['pharmacy']['location']['lng'] is int
              ? (data['pharmacist']['pharmacy']['location']['lng'] as int)
                  .toDouble()
              : (data['pharmacist']['pharmacy']['location']['lng']) as double;

      if (data['pharmacist']['profileImage'] != null) {
        newPharmacist.pharmacyImage = data['pharmacist']['profileImage'];
      } else {
        newPharmacist.pharmacyImage = 'null';
      }

      await newPharmacist.save();

      mainPharmacist = await box.get('pharmacist');

      appMode = await box.get('mode');

      //Initalize Socket Connection
      await socketConnection.initSocket();

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUpPatient(
      {bodyRequest}) async {
    try {
      var data = await apiService.post(
        endPoint: "patient/signup",
        bodyRequest: bodyRequest,
      );

      if (data['verificationToken'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> signUpPharmacist({
    required XFile? pickedFile,
    required String name,
    required String email,
    required String password,
    required String pharmacyName,
    required double lat,
    required double lng,
  }) async {
    try {
      File imageFile = File(pickedFile!.path);
      String imagePath = imageFile.path;

      String fileType = path.extension(imagePath).toLowerCase();
      fileType = fileType.substring(1);

      Map<String, dynamic> data = {}; 
      try {
        FormData formData = FormData.fromMap({
          'licenseImages': await MultipartFile.fromFile(imagePath,
              filename: path.basename(imagePath),
              contentType: MediaType('licenseImages', fileType)),
          'name': name,
          'email': email,
          'password': password,
          'pharmacyName': pharmacyName,
          'location': {"lng": lng, "lat": lat}
        });

        data = await apiService.postFormData(
            endPoint: 'pharmacist/signup', formData: formData);
      } catch (e) {}

      if (data['verificationToken'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verificationCodePatient(
      {bodyRequest}) async {
    try {
      var data = await apiService.post(
        endPoint: "patient/verify",
        bodyRequest: bodyRequest,
      );

      if (data['patient'] == null && data['extraData'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verificationCodePharmacist(
      {bodyRequest}) async {
    try {
      var data = await apiService.post(
        endPoint: "pharmacist/verify",
        bodyRequest: bodyRequest,
      );

      if (data['message'] ==
          "verification done successfully, but the license hasn't been validated yet!") {
        return right(data);
      }

      if (data['pharmacist'] == null && data['extraData'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  Future<void> refreshToken(Timer timer) async {
    UpdateToken updateToken = UpdateToken();
    await updateToken.updateToken();
  }
}
