part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesFailure extends CategoriesState {
  final String errMessage;

  CategoriesFailure({required this.errMessage});
}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  CategoriesSuccess({required this.categories});
}

class CategoriesProductsSelect extends CategoriesState {
  final int selectCategory;

  CategoriesProductsSelect({required this.selectCategory});
}