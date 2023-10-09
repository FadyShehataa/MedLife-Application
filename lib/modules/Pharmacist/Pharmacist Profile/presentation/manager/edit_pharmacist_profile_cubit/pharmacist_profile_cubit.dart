import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Pharmacist%20Profile/data/repos/pharmacist_profile_repo.dart';
import 'package:meta/meta.dart';

part 'pharmacist_profile_state.dart';

class PharmacistProfileCubit extends Cubit<PharmacistProfileState> {
  PharmacistProfileCubit(this.pharmacistProfileRepo)
      : super(PharmacistProfileInitial());

  final PharmacistProfileRepo pharmacistProfileRepo;

  var img = true;

  static PharmacistProfileCubit get(context) => BlocProvider.of(context);

  void imgVisibility() {
    img = !img;
    emit(ImgVisibility());
  }

  Future<void> updateImage({XFile? pickedImage}) async {
    emit(PharmacistProfileLoading());

    var result = await pharmacistProfileRepo.updateImage(pickedImage: pickedImage);


    result.fold(
          (failure) => emit(PharmacistProfileFailure(errMessage: failure.errMessage)),
          (_) => emit(PharmacistProfileSucess()),
    );
  }


  Future<void> editPharmacistPassword({dynamic bodyRequest}) async {
    emit(PharmacistProfileLoading());

    var result = await pharmacistProfileRepo.editPharmacistPassword(
        bodyRequest: bodyRequest);

    result.fold(
      (failure) =>
          emit(PharmacistProfileFailure(errMessage: failure.errMessage)),
      (_) => emit(EditPasswordSuccess()),
    );
  }

  Future<void> editPharmacyName({dynamic bodyRequest}) async {
    emit(PharmacistProfileLoading());

    var result =
        await pharmacistProfileRepo.editPharmacyName(bodyRequest: bodyRequest);

    result.fold(
      (failure) =>
          emit(PharmacistProfileFailure(errMessage: failure.errMessage)),
      (_) => emit(EditPharmacyNameSuccess()),
    );
  }

  Future<void> editPharmacistName({dynamic bodyRequest}) async {
    emit(PharmacistProfileLoading());

    var result = await pharmacistProfileRepo.editPharmacistName(
        bodyRequest: bodyRequest);

    result.fold(
      (failure) =>
          emit(PharmacistProfileFailure(errMessage: failure.errMessage)),
      (_) => emit(EditPharmacistNameSuccess()),
    );
  }


  Future<void> deleteImage() async {
    emit(PharmacistProfileLoading());

    var result = await pharmacistProfileRepo.deleteImage();

    result.fold(
          (failure) => emit(PharmacistProfileFailure(errMessage: failure.errMessage)),
          (_) => emit(PharmacistProfileSucess()),
    );
  }

}
