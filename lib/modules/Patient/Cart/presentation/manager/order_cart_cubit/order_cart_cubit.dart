import 'package:bloc/bloc.dart';
import '../../../data/repos/cart_repo.dart';
import 'package:meta/meta.dart';

part 'order_cart_state.dart';

class OrderCartCubit extends Cubit<OrderCartState> {
  OrderCartCubit(this.cartRepo) : super(OrderCartInitial());
  final CartRepo cartRepo;

  Future<void> orderCart({dynamic bodyRequest}) async {
    emit(OrderCartLoading());
    var result = await cartRepo.orderCart(bodyRequest: bodyRequest);
    result.fold(
      (failure) => emit(OrderCartFailure(errMessage: failure.errMessage)),
      (_) {
        emit(OrderCartSuccess());
      },
    );
  }
}
