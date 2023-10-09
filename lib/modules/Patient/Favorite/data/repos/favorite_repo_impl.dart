import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/utils/api_service.dart';

import '../model/favorite_model/favorite_model.dart';
import 'favorite_repo.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  FavoriteRepoImpl(this.apiService);
  ApiService apiService;

  @override
  Future<Either<Failure, List<FavoriteModel>>> fetchFavorite() async {
    var data;
    try {
      data = await apiService.get(endPoint: 'patient/favorites');

      List<FavoriteModel> favorites = [];

      for (var item in data['favorites']) {
        favorites.add(FavoriteModel.fromJson(item));
      }
      return right(favorites);
    } catch (e) {

      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteModel>>> deleteItemFromFavorite(
      {required String cartID}) async {
    try {
      var data = await apiService.delete(
          endPoint: 'patient/favorites/$cartID');
      List<FavoriteModel> favorites = [];

      for (var item in data['favorites']) {
        favorites.add(FavoriteModel.fromJson(item));
      }
      return right(favorites);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteModel>>> addItemToFavorite(
      {required String cartID}) async {
    try {
      var data = await apiService.post(
          endPoint: 'patient/favorites/$cartID');
      List<FavoriteModel> favorites = [];

      for (var item in data['favorites']) {
        favorites.add(FavoriteModel.fromJson(item));
      }
      return right(favorites);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
