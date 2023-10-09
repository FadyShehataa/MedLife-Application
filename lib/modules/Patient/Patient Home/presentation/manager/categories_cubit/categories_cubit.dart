import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/category_model/category_model.dart';
import '../../../data/repos/patient_home_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.patientHomeRepo) : super(CategoriesInitial());

  final PatientHomeRepo patientHomeRepo;

  List<CategoryModel> categories = [];

  int selectCategory = 0 ;

  Future<void> selectCategoryQuery(int selectCategory)async {
    this.selectCategory = selectCategory;
    emit(CategoriesProductsSelect(selectCategory: selectCategory));
  }

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());

    var result = await patientHomeRepo.fetchCategories();

    result.fold(
      (failure) => emit(CategoriesFailure(errMessage: failure.errMessage)),
      (categories) {
        emit(CategoriesSuccess(categories: categories));
        this.categories = categories;
      },
    );
  }
}

