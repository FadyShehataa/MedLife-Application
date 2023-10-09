part of 'prescription_cubit.dart';

@immutable
abstract class PrescriptionState {}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionLoading extends PrescriptionState {}

class PrescriptionFailure extends PrescriptionState {
  final String errMessage;

  PrescriptionFailure({required this.errMessage});
}

class PrescriptionSuccess extends PrescriptionState {
  final List<PrescriptionModel> prescriptionProducts;
  PrescriptionSuccess({required this.prescriptionProducts});
}
