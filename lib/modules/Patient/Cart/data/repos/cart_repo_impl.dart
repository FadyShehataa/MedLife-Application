// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medlife_app/core/errors/failures.dart';
import 'package:medlife_app/core/utils/api_service.dart';

import '../models/cart_model/cart_model.dart';
import 'cart_repo.dart';

class CartRepoImpl implements CartRepo {
  CartRepoImpl(this.apiService);
  ApiService apiService;

  @override
  Future<Either<Failure, List<CartModel>>> fetchCart() async {
    try {
      var data = await apiService.get(endPoint: 'patient/cart');

      List<CartModel> cart = [];

      for (var item in data['cart']) {
        cart.add(CartModel.fromJson(item));
      }
      return right(cart);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> deleteItemFromCart(
      {required String cartID, required String quantity}) async {
    try {
      var data = await apiService.delete(
          endPoint: 'patient/cart/$cartID', quantity: quantity);
      List<CartModel> cart = [];

      for (var item in data['cart']) {
        cart.add(CartModel.fromJson(item));
      }
      return right(cart);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> decreaseItemFromCart(
      {required String cartID}) async {
    try {
      var data = await apiService.delete(endPoint: 'patient/cart/$cartID');
      List<CartModel> cart = [];

      for (var item in data['cart']) {
        cart.add(CartModel.fromJson(item));
      }
      return right(cart);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartModel>>> addItemToCart(
      {required String cartID}) async {
    try {
      var data = await apiService.post(
          endPoint: 'patient/cart', queryParameter: cartID);

      List<CartModel> cart = [];

      if (data['message'] == 'you reached the maximum stock of this product!') {
        return left(ServerFailure(
            errMessage: 'you reached the maximum stock of this product!'));
      }

      for (var item in data['cart']) {
        cart.add(CartModel.fromJson(item));
      }
      return right(cart);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> orderCart({bodyRequest}) async {
    try {
      var data = await apiService.put(
          endPoint: 'patient/cart/order', bodyRequest: bodyRequest);

      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> notifyMeWhenAvailable(
      {dynamic productId, dynamic pharmacyId}) async {
    try {
      var data = await apiService.post(
          endPoint: 'patient/notify-when-available/requests/create',
          bodyRequest: {"productId": productId, "pharmacyId": pharmacyId});


      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
