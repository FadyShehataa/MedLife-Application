part of 'favorite_cubit.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteFailure extends FavoriteState {
  final String errMessage;

  FavoriteFailure({required this.errMessage});
}

class FavoriteSuccess extends FavoriteState {
  final List<FavoriteModel> favorites;

  FavoriteSuccess({required this.favorites});
}
