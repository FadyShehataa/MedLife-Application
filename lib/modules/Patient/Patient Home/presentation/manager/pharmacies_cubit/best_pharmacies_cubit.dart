import 'package:bloc/bloc.dart';
import '../../../../Patient%20Home/data/repos/patient_home_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/pharmacy_model/pharmacy_model.dart';

part 'best_pharmacies_state.dart';

class BestPharmaciesCubit extends Cubit<BestPharmaciesState> {
  BestPharmaciesCubit(this.patientHomeRepo) : super(BestPharmaciesInitial());

  final PatientHomeRepo patientHomeRepo;

  List<PharmacyModel> bestPharmacies = [];


  Future<void> fetchBestPharmacies() async {
    emit(BestPharmaciesLoading());

    var result = await patientHomeRepo.fetchBestPharmacies();

    result.fold(
          (failure) => emit(BestPharmaciesFailure(errMessage: failure.errMessage)),
          (bestPharmacies) => emit(BestPharmaciesSuccess(bestPharmacies: bestPharmacies)),
    );
  }
}
