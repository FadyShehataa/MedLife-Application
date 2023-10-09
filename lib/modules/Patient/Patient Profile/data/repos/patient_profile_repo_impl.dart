import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../Patient%20Profile/data/repos/patient_profile_repo.dart';
import '../../../../../core/utils/constants.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';



class PatientProfileRepoImpl implements PatientProfileRepo {
  ApiService apiService;
  PatientProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> editPatientPassword({bodyRequest}) async {
    try {
      var data = await apiService.put(
        endPoint: "patient/update",
        bodyRequest: bodyRequest,
      );

      if (data['patient'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> editPatientName({bodyRequest})async {
    try {
      var data = await apiService.put(
        endPoint: "patient/update",
        bodyRequest: bodyRequest,
      );

      if (data['patient'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      mainPatient!.name = data['patient']['name'];
      await mainPatient!.save();

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateImage({pickedImage}) async {
    try {
      File imageFile = File(pickedImage!.path);
      String imagePath = imageFile.path;

      String fileType = path.extension(imagePath).toLowerCase();
      fileType = fileType.substring(1);


      FormData formData = FormData.fromMap({
        'profileImage': await MultipartFile.fromFile(imagePath, filename: path.basename(imagePath), contentType: MediaType('image', fileType)),
        'name': mainPatient!.name,
      });

      var data = await apiService.putFormData(
        endPoint: "patient/update",
        formData: formData,
      );

      if(data['patient']['profileImage'] != null){
        mainPatient!.imageURL = data['patient']['profileImage'];
        await mainPatient!.save();

      } else {
        mainPatient!.imageURL = '';
        await mainPatient!.save();
      }

      if (data['patient'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteImage()async {
    try {


      await apiService.put(endPoint: "patient/update", bodyRequest: {
        "name": mainPatient!.name,
        "removeProfileImage": true,
      });


      mainPatient!.imageURL = '';
      await mainPatient!.save();

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
