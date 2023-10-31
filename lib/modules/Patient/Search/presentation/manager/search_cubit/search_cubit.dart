import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medlife_app/modules/PATIENT/Prescription%20OCR/data/models/prescription_model/prescription_model.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/utils/Controllers/Location.dart';
import '../../../../Patient Home/data/models/pharmacy_model/pharmacy_model.dart';
import '../../../../Patient Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';
import '../../../data/repos/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());

  late Position? currentPosition;

  static SearchCubit get(context) => BlocProvider.of(context);

  void updatePosition(position) {
    currentPosition = position;
    emit(UpdatePosition());
  }

  final SearchRepo searchRepo;

  Future<void> fetchPharmacies({required String searchKey}) async {
    emit(SearchLoading());

    var result = await searchRepo.fetchPharmacies(pharmacyName: searchKey);

    result.fold(
      (failure) => emit(SearchFailure(errMessage: failure.errMessage)),
      (pharmacies) => emit(SearchPharmacySuccess(pharmacies: pharmacies)),
    );
  }

  Future<void> fetchProductInPharmacy(
      {required String pharmacyId, required String productName}) async {
    emit(SearchLoading());

    var result = await searchRepo.fetchProductInPharmacy(
        pharmacyId: pharmacyId, productName: productName);

    result.fold(
      (failure) => emit(SearchFailure(errMessage: failure.errMessage)),
      (products) => emit(SearchProductInPharmacySuccess(products: products)),
    );
  }

  Future<void> fetchProductInPharmacies(
      {required String productName, double? lat, double? long}) async {
    emit(SearchLoading());

    var result =
        await searchRepo.fetchProductInPharmacies(productName: productName);

    result
        .fold((failure) => emit(SearchFailure(errMessage: failure.errMessage)),
            (searchResult) {
      Coordinate coordinate = Coordinate(lat!, long!);

      List<PrescriptionModel> sortedItems =
          sortByDistance(coordinate, searchResult.cast<PrescriptionModel>());

      emit(SearchProductInPharmaciesSuccess(products: sortedItems));
    });
  }

  void sort({required var result, required var address}) {}
}
