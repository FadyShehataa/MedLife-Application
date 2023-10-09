import 'package:bloc/bloc.dart';
import '../../../../Patient%20Home/data/repos/patient_home_repo.dart';
import 'package:meta/meta.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit(this.patientHomeRepo) : super(RatingInitial());

  final PatientHomeRepo patientHomeRepo;

  Future<void> reviewPharmacy(
      {required String pharmacyID, dynamic bodyRequest}) async {
    emit(RatingLoading());

    var result = await patientHomeRepo.reviewPharmacy(
        pharmacyID: pharmacyID, bodyRequest: bodyRequest);

    result.fold(
      (failure) => emit(RatingFailure(errMessage: failure.errMessage)),
      (categories) => emit(RatingSuccess()),
    );
  }
}
