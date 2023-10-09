import 'package:bloc/bloc.dart';
import '../../../data/models/pharmacist_order/pharmacist_order.dart';
import '../../../data/repos/pharmacist_order_repo.dart';
import 'package:meta/meta.dart';

part 'pharmacist_orders_state.dart';

class PharmacistOrdersCubit extends Cubit<PharmacistOrdersState> {
  PharmacistOrdersCubit(this.pharmacistOrderRepo)
      : super(PharmacistOrdersInitial());

  final PharmacistOrderRepo pharmacistOrderRepo;
  List<PharmacistOrderModel> orders = [];
  String orderStatus = '';

  Future<void> fetchPharmacistOrders() async {
    emit(PharmacistOrdersLoading());

    var result = await pharmacistOrderRepo.fetchPharmacistOrders();

    result.fold(
      (failure) =>
          emit(PharmacistOrdersFailure(errMessage: failure.errMessage)),
      (orders) {
        this.orders = orders;
        emit(PharmacistOrdersSuccess(orders: orders));
      },
    );
  }

  Future<void> confirmPharmacistOrder(
      {dynamic bodyRequest, String? orderId}) async {
    emit(PharmacistOrdersLoading());
    var result = await pharmacistOrderRepo.confirmPharmacistOrder(
        bodyRequest: bodyRequest, orderId: orderId);

    result.fold(
      (failure) =>
          emit(PharmacistOrdersFailure(errMessage: failure.errMessage)),
      (_) {
        fetchPharmacistOrders();
        // emit(PharmacistOrdersSuccess(orders: orders));
      },
    );
  }

  Future<void> searchPharmacyProductsQuery(String query) async {
    emit(SearchQueryState(orderStatus: query));
    orderStatus = query;
  }
}
