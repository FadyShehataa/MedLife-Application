import 'dart:convert';

import 'package:dio/dio.dart';
import 'constants.dart';


class ApiService {
  final String _baseUrl = 'http://13.39.13.134:8080/api/';
  final Dio _dio;

  ApiService(this._dio);

  Future<String?> getToken() async {
    if(appMode?.userType == 'patient') {
      token = 'Bearer ${mainPatient?.token}';

    } else if (appMode?.userType == 'pharmacist') {
      token = 'Bearer ${mainPharmacist?.token}';
    }

    return token;
  }

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    _dio.options.headers['Authorization'] = await getToken();
    var response = await _dio.get('$_baseUrl$endPoint');

    return response.data;
  }

  Future<Map<String, dynamic>> delete(
      {required String endPoint, String? quantity, dynamic bodyRequest}) async {
    _dio.options.headers['Authorization'] = await getToken();
    Response response;
    if (bodyRequest != null) {
      response = await _dio.delete('$_baseUrl$endPoint', data: bodyRequest);
    } else if (quantity != null) {
      response = await _dio.delete('$_baseUrl$endPoint?quantity=$quantity');
    } else {
      response = await _dio.delete('$_baseUrl$endPoint');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint,
      String? queryParameter,
      dynamic bodyRequest}) async {
    _dio.options.headers['Authorization'] = await getToken();
    Response response = Response(requestOptions: RequestOptions());
    try {
      if (queryParameter != null) {
        response = await _dio.post('$_baseUrl$endPoint/$queryParameter');
      } else if (bodyRequest != null) {
        response = await _dio.post('$_baseUrl$endPoint',
            data: jsonEncode(bodyRequest));
      } else {
        response = await _dio.post('$_baseUrl$endPoint');
      }
      return response.data;
    } catch (e) {
      if (e is DioException) {
        return e.response!.data as Map<String, dynamic>;
      }
      return response.data;
    }
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint, dynamic bodyRequest}) async {
    _dio.options.headers['Authorization'] = await getToken();


    Response response = Response(requestOptions: RequestOptions());
    try {
      response =
          await _dio.put('$_baseUrl$endPoint', data: jsonEncode(bodyRequest));
      return response.data;
    } catch (e) {
      if (e is DioException) {
        return e.response!.data as Map<String, dynamic>;
      }
      return response.data;
    }
  }

  Future<Map<String, dynamic>> putFormData(
      {required String endPoint, required FormData formData}) async {
    _dio.options.headers['Authorization'] = await getToken();

    Response response = Response(requestOptions: RequestOptions());
    try {
      response = await _dio.put('$_baseUrl$endPoint', data: formData);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        return e.response!.data as Map<String, dynamic>;
      }
      return response.data;
    }
  }

  Future<Map<String, dynamic>> postFormData(
      {required String endPoint, required FormData formData}) async {
    Response response = Response(requestOptions: RequestOptions());
    try {
      response = await _dio.post('$_baseUrl$endPoint', data: formData);
      return response.data;
    } catch (e) {

      if (e is DioException) {
        return e.response!.data as Map<String, dynamic>;
      }
      return response.data;
    }
  }
}
