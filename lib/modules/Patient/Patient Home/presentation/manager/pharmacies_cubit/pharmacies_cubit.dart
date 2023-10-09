import 'package:bloc/bloc.dart';
import '../../../../Patient%20Home/data/repos/patient_home_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/pharmacy_model/pharmacy_model.dart';

part 'pharmacies_state.dart';

class PharmaciesCubit extends Cubit<PharmaciesState> {
  PharmaciesCubit(this.patientHomeRepo) : super(PharmaciesInitial());

  final PatientHomeRepo patientHomeRepo;

  List<PharmacyModel> pharmacies = [];

  Future<void> fetchPharmacies() async {
    emit(PharmaciesLoading());

    var result = await patientHomeRepo.fetchPharmacies();

    result.fold(
      (failure) => emit(PharmaciesFailure(errMessage: failure.errMessage)),
      (pharmacies) => emit(PharmaciesSuccess(pharmacies: pharmacies)),
    );
  }
}
