part of 'rating_cubit.dart';

@immutable
abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingFailure extends RatingState {
  final String errMessage;

  RatingFailure({required this.errMessage});
}

class RatingSuccess extends RatingState {}
