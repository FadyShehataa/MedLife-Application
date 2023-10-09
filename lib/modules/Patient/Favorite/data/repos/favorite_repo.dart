import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';

import '../model/favorite_model/favorite_model.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, List<FavoriteModel>>> fetchFavorite();
  Future<Either<Failure, List<FavoriteModel>>> deleteItemFromFavorite(
      {required String cartID});
  Future<Either<Failure, List<FavoriteModel>>> addItemToFavorite(
      {required String cartID});
}
