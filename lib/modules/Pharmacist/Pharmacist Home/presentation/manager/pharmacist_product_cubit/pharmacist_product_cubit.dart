import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Home/data/models/pharmacist_product_model/pharmacist_product_model.dart';
import '../../../../Pharmacist%20Home/data/repos/pharmacist_products_repo.dart';

part 'pharmacist_product_state.dart';

class PharmacistProductCubit extends Cubit<PharmacistProductState> {
  PharmacistProductCubit(this.pharmacistProductsRepo)
      : super(PharmacistProductInitial());

  final PharmacistProductsRepo pharmacistProductsRepo;
  List<PharmacistProductModel> pharmacyProducts = [];

  TextEditingController searchPharmacyProductsController =
      TextEditingController();

  Future<void> searchPharmacyProductsQuery(String query) async {
    emit(SearchQueryState(search: query));
    searchPharmacyProductsController.text = query;
  }

  Future<void> fetchPharmacyProducts({required String pharmacyID}) async {
    emit(PharmacistProductLoading());

    var result = await pharmacistProductsRepo.fetchPharmacyProducts(
        pharmacyID: pharmacyID);

    result.fold(
      (failure) =>
          emit(PharmacistProductFailure(errMessage: failure.errMessage)),
      (products) {
        emit(PharmacistProductSuccess(products: products));
        pharmacyProducts = products;
      },
    );
  }

  Future<void> deletePharmacyProduct({required dynamic bodyRequest}) async {
    var result = await pharmacistProductsRepo.deletePharmacyProduct(
        bodyRequest: bodyRequest);

    result.fold(
      (failure) =>
          emit(PharmacistProductFailure(errMessage: failure.errMessage)),
      (deleteProduct) {
        int index = pharmacyProducts
            .indexWhere((element) => element.id == deleteProduct.id);
        pharmacyProducts[index].price = deleteProduct.price;
        pharmacyProducts[index].amount = deleteProduct.amount;
        emit(PharmacistProductSuccess(products: pharmacyProducts));
      },
    );
  }

  Future<void> editPharmacyProduct({required dynamic bodyRequest}) async {
    emit(PharmacistProductLoading());
    var result = await pharmacistProductsRepo.editPharmacyProduct(
        bodyRequest: bodyRequest);

    result.fold(
      (failure) =>
          emit(PharmacistProductFailure(errMessage: failure.errMessage)),
      (addProduct) {
        int index = pharmacyProducts
            .indexWhere((element) => element.id == addProduct.id);
        pharmacyProducts[index].price = addProduct.price;
        pharmacyProducts[index].amount = addProduct.amount;

        emit(PharmacistProductSuccess(products: pharmacyProducts));
      },
    );
  }
}
