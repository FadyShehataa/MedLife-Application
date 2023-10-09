// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/modules/PATIENT/Prescription%20OCR/data/models/prescription_model/prescription_model.dart';
import 'package:medlife_app/modules/PATIENT/Prescription%20OCR/data/repos/prescription_ocr_repo.dart';

import '../../../../../core/errors/failures.dart';

class PrescriptionOCRRepoImpl implements PrescriptionOCRRepo {
  ApiService apiService;
  PrescriptionOCRRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<PrescriptionModel>>> fetchPrescription(
      {XFile? pickedFile}) async {
    List<PrescriptionModel> prescriptionProducts = [];
    try {

      File imageFile = File(pickedFile!.path);
      String imagePath = imageFile.path;

      String fileType = path.extension(imagePath).toLowerCase();
      fileType = fileType.substring(1);


      try {
        FormData formData = FormData.fromMap({
          'images': await MultipartFile.fromFile(imagePath, filename: path.basename(imagePath), contentType: MediaType('image', fileType)),
        });

        var data = await apiService.postFormData(
            endPoint: 'ml/image', formData: formData);


        for (var item in data['products']) {
          prescriptionProducts.add(PrescriptionModel.fromJson(item));
        }


      } catch (e) {
      }


      return right(prescriptionProducts);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
