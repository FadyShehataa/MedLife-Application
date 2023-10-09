import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/pharmacy_product_model/pharmacy_product_model.dart';
import '../../../data/repos/patient_home_repo.dart';

part 'pharmacy_products_state.dart';

class PharmacyProductsCubit extends Cubit<PharmacyProductsState> {
  PharmacyProductsCubit(this.patientHomeRepo)
      : super(PharmacyProductsInitial());

  final PatientHomeRepo patientHomeRepo;

  List<PharmacyProductModel> pharmacyProducts = [];

  Future<void> fetchPharmacyProducts(
      {required String pharmacyID}) async {
    emit(PharmacyProductsLoading());

    var result = await patientHomeRepo.fetchPharmacyProducts(
        pharmacyID: pharmacyID);

    result.fold(
      (failure) =>
          emit(PharmacyProductsFailure(errMessage: failure.errMessage)),
      (pharmacyProducts) {
        emit(PharmacyProductsSuccess(pharmacyProducts: pharmacyProducts));
        this.pharmacyProducts = pharmacyProducts;
      },
    );
  }


}
