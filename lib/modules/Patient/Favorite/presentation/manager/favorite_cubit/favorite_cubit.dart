import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/favorite_model/favorite_model.dart';
import '../../../data/repos/favorite_repo.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());
  final FavoriteRepo favoriteRepo;
  List<FavoriteModel> favorites = [];

  Future<void> fetchFavorite() async {
    emit(FavoriteLoading());

    var result = await favoriteRepo.fetchFavorite();

    result.fold(
      (failure) => emit(FavoriteFailure(errMessage: failure.errMessage)),
      (favorites) {
        emit(FavoriteSuccess(favorites: favorites));
        this.favorites = favorites;
      },
    );
  }

  Future<void> deleteItemFromFavorite({required String cartID}) async {

    var result = await favoriteRepo.deleteItemFromFavorite(cartID: cartID);

    result.fold(
      (failure) => emit(FavoriteFailure(errMessage: failure.errMessage)),
      (favorites) {
        emit(FavoriteSuccess(favorites: favorites));
        this.favorites = favorites;
      },
    );
  }

  Future<void> addItemToFavorite({required String cartID}) async {
    emit(FavoriteLoading());

    var result = await favoriteRepo.addItemToFavorite(cartID: cartID);

    result.fold(
      (failure) => emit(FavoriteFailure(errMessage: failure.errMessage)),
      (favorites) {
        emit(FavoriteSuccess(favorites: favorites));
        this.favorites = favorites;
      },
    );
  }
}
