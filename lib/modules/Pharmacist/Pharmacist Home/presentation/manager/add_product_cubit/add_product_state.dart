part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class SearchQueryAddProductState extends AddProductState {
  final String search;

  SearchQueryAddProductState({required this.search});
}

class AddProductLoading extends AddProductState {}

class AddProductFailure extends AddProductState {
  final String errMessage;

  AddProductFailure({required this.errMessage});
}

class AddProductSuccess extends AddProductState {
  final List<AddProductModel> systemProducts;

  AddProductSuccess({required this.systemProducts});
}
