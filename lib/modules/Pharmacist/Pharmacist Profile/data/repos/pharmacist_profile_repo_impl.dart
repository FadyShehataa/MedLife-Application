
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';



import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../Pharmacist%20Profile/data/repos/pharmacist_profile_repo.dart';
import '../../../../../core/utils/constants.dart';

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';


class PharmacistProfileRepoImpl implements PharmacistProfileRepo {
  ApiService apiService;
  PharmacistProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, void>> editPharmacistName({bodyRequest}) async {
    try {
      var data = await apiService.put(
        endPoint: "pharmacist/update",
        bodyRequest: bodyRequest,
      );

      if (data['pharmacist'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      mainPharmacist!.name = data['pharmacist']['name'];
      await mainPharmacist!.save();

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editPharmacistPassword({bodyRequest}) async {
    try {
      var data = await apiService.put(
        endPoint: "pharmacist/update",
        bodyRequest: bodyRequest,
      );

      if (data['pharmacist'] == null) {
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
  Future<Either<Failure, void>> editPharmacyName({bodyRequest}) async {
    try {
      var data = await apiService.put(
        endPoint: "pharmacist/update",
        bodyRequest: bodyRequest,
      );

      if (data['pharmacist'] == null) {
        return left(ServerFailure(errMessage: data['message']));
      }

      mainPharmacist!.pharmacyName = data['pharmacist']['pharmacy']['name'];
      await mainPharmacist!.save();

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateImage({pickedImage})async {
    try {
      File imageFile = File(pickedImage!.path);
      String imagePath = imageFile.path;

      String fileType = path.extension(imagePath).toLowerCase();
      fileType = fileType.substring(1);


      FormData formData = FormData.fromMap({
        'profileImage': await MultipartFile.fromFile(imagePath, filename: path.basename(imagePath), contentType: MediaType('image', fileType)),
        'name': mainPharmacist!.name,
        'pharmacyName': mainPharmacist!.pharmacyName,
        'location': { "lng": mainPharmacist!.lng, "lat": mainPharmacist!.lat,},
        "isChattingAvailable": true,
        "isDeliveryAvailable": true

      });

      var data = await apiService.putFormData(
        endPoint: "pharmacist/update",
        formData: formData,
      );

      if(data['pharmacist']['profileImage'] != null){
        mainPharmacist!.pharmacyImage = data['pharmacist']['profileImage'] ;
      } else {
        mainPharmacist!.pharmacyImage = 'null';
      }
      await mainPharmacist!.save();

      if (data['pharmacist'] == null) {
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


      await apiService.put(endPoint: "pharmacist/update", bodyRequest: {
        "name": mainPharmacist!.name,
        "removeProfileImage": true,
      });

      mainPharmacist!.pharmacyImage = '';


      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

}
