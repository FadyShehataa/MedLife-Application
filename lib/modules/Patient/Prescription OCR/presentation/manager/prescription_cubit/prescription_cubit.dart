import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Prescription%20OCR/data/models/prescription_model/prescription_model.dart';
import '../../../../Prescription%20OCR/data/repos/prescription_ocr_repo.dart';
import 'package:meta/meta.dart';

part 'prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  PrescriptionCubit(this.prescriptionOCRRepo) : super(PrescriptionInitial());

  List<PrescriptionModel> prescriptionProducts = [];
  final PrescriptionOCRRepo prescriptionOCRRepo;

  Future<void> fetchPrescription({XFile? pickedFile}) async {
    emit(PrescriptionLoading());

    var result =
        await prescriptionOCRRepo.fetchPrescription(pickedFile: pickedFile);

    result.fold(
      (failure) => emit(PrescriptionFailure(errMessage: failure.errMessage)),
      (prescriptionProducts) {
        this.prescriptionProducts = prescriptionProducts;
        emit(PrescriptionSuccess(prescriptionProducts: prescriptionProducts));
      },
    );
  }
}
