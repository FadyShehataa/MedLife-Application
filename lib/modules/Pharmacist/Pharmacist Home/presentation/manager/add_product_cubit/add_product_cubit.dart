import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Home/data/models/add_product_model/add_product_model.dart';
import '../../../../Pharmacist%20Home/data/repos/pharmacist_products_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.pharmacistProductsRepo) : super(AddProductInitial());

  final PharmacistProductsRepo pharmacistProductsRepo;

  TextEditingController searchAddProductController = TextEditingController();
  List<AddProductModel> systemProducts = [];

  Future<void> fetchSystemProducts() async {
    emit(AddProductLoading());

    var result = await pharmacistProductsRepo.fetchSystemProducts();

    result.fold(
      (failure) => emit(AddProductFailure(errMessage: failure.errMessage)),
      (systemProducts) {
        emit(AddProductSuccess(systemProducts: systemProducts));
        this.systemProducts = systemProducts;
      },
    );
  }

  Future<void> searchAddProductQuery(String query) async {
    emit(SearchQueryAddProductState(search: query));
    searchAddProductController.text = query;
  }

  Future<void> addProductToPharmacy({dynamic bodyRequest}) async {
    emit(AddProductLoading());

    var result = await pharmacistProductsRepo.addProductToPharmacy(
        bodyRequest: bodyRequest);

    result.fold(
      (failure) => emit(AddProductFailure(errMessage: failure.errMessage)),
      (addProduct) {
        systemProducts = systemProducts
            .where((element) => element.id != addProduct.product!.id)
            .toList();
        emit(AddProductSuccess(systemProducts: systemProducts));
      },
    );
  }
}
