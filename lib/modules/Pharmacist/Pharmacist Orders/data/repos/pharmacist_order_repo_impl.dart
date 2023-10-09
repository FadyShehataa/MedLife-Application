// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist Orders/data/models/pharmacist_order/pharmacist_order.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist Orders/data/repos/pharmacist_order_repo.dart';

class PharmacistOrderRepoImpl implements PharmacistOrderRepo {
  ApiService apiService;
  PharmacistOrderRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<PharmacistOrderModel>>>
      fetchPharmacistOrders() async {
    try {
      var data = await apiService.get(endPoint: 'pharmacist/orders');

      List<PharmacistOrderModel> orders = [];

      for (var item in data['orders']) {
        orders.add(PharmacistOrderModel.fromJson(item));
      }
      return right(orders);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPharmacistOrder(
      {dynamic bodyRequest, String? orderId}) async {
    try {
      var data = await apiService.post(
          endPoint: 'pharmacist/orders/$orderId/confirm',
          bodyRequest: bodyRequest);


      if (data['message'] == "this order is confirmed already!" ||
          data['message'] == "order confirmed successfully!") {
        return right(null);
      } else {
        return left(ServerFailure(errMessage: data['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
