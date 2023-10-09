part of 'filter_search_cubit.dart';

@immutable
abstract class FilterSearchState {}

class FilterSearchInitial extends FilterSearchState {}



class UpdatePosition extends FilterSearchState {}

class FindPharmacyType extends FilterSearchState {}
class FindProductInNearestPharmacyType extends FilterSearchState {}


class FilterSearchPharmacies extends FilterSearchState {}

class FilterSearchProductInPharmacy extends FilterSearchState {}

class FilterSearchProductInPharmacies extends FilterSearchState {}


