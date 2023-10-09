import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Patient%20Profile/data/repos/patient_profile_repo.dart';
import 'package:meta/meta.dart';

part 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  PatientProfileCubit(this.patientProfileRepo) : super(PatientProfileInitial());

  final PatientProfileRepo patientProfileRepo;

  var img = true;

  static PatientProfileCubit get(context) => BlocProvider.of(context);

  void imgVisibility() {
    img = !img;
    emit(ImgVisibility());
  }


  Future<void> editPatientPassword({dynamic bodyRequest}) async {
    emit(PatientProfileLoading());

    var result =
        await patientProfileRepo.editPatientPassword(bodyRequest: bodyRequest);

    result.fold(
      (failure) => emit(PatientProfileFailure(errMessage: failure.errMessage)),
      (_) => emit(PatientProfileSuccess()),
    );
  }

  Future<void> editPatientName({dynamic bodyRequest}) async {
    emit(PatientProfileLoading());

    var result =
        await patientProfileRepo.editPatientName(bodyRequest: bodyRequest);

    result.fold(
      (failure) => emit(PatientProfileFailure(errMessage: failure.errMessage)),
      (_) => emit(PatientProfileSuccess()),
    );
  }

  Future<void> updateImage({XFile? pickedImage}) async {
    emit(PatientProfileLoading());

    var result = await patientProfileRepo.updateImage(pickedImage: pickedImage);


    result.fold(
      (failure) => emit(PatientProfileFailure(errMessage: failure.errMessage)),
      (_) => emit(PatientProfileSuccess()),
    );
  }

  Future<void> deleteImage() async {
    emit(PatientProfileLoading());

    var result = await patientProfileRepo.deleteImage();

    result.fold(
      (failure) => emit(PatientProfileFailure(errMessage: failure.errMessage)),
      (_) => emit(PatientProfileSuccess()),
    );
  }

}
