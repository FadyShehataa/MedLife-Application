import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../data/repos/cart_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/cart_model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());
  final CartRepo cartRepo;

  bool notifyMe = false;

  List<CartModel> cart = [];
  double totalPrice = 0;

  late Position? currentPosition;

  static CartCubit get(context) => BlocProvider.of(context);

  void updatePosition(position) {
    currentPosition = position;
    emit(UpdatePosition());
  }


  Future<void> fetchCart() async {
    emit(CartLoading());

    var result = await cartRepo.fetchCart();

    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.errMessage)),
      (cart) {
        emit(CartSuccess(cart: cart));
        this.cart = cart;
        totalPrice = 0;
        for (var item in cart) {
          totalPrice += (item.price! * item.quantity!);
        }
      },
    );
  }

  Future<void> deleteItemFromCart(
      {required String cartID, required String quantity}) async {
    var result =
        await cartRepo.deleteItemFromCart(cartID: cartID, quantity: quantity);

    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.errMessage)),
      (cart) {
        emit(CartSuccess(cart: cart));
        this.cart = cart;
        totalPrice = 0;
        for (var item in cart) {
          totalPrice += (item.price! * item.quantity!);
        }
      },
    );
  }

  Future<void> decreaseItemFromCart({required String cartID}) async {
    var result = await cartRepo.decreaseItemFromCart(cartID: cartID);

    result.fold(
      (failure) => emit(CartFailure(errMessage: failure.errMessage)),
      (cart) {
        emit(CartSuccess(cart: cart));
        this.cart = cart;
        totalPrice = 0;
        for (var item in cart) {
          totalPrice += (item.price! * item.quantity!);
        }
      },
    );
  }

  Future<void> addItemToCart({required String cartID}) async {
    var result = await cartRepo.addItemToCart(cartID: cartID);

    result.fold(
      (failure) {
        if(failure.errMessage == 'you reached the maximum stock of this product!') {
          notifyMe = true;
        } else {
          emit(CartFailure(errMessage: failure.errMessage));
        }
      },
      (cart) {
        emit(CartSuccess(cart: cart));
        this.cart = cart;
        totalPrice = 0;
        for (var item in cart) {
          totalPrice += (item.price! * item.quantity!);
        }
      },
    );
  }

  Future<void> notifyMeWhenAvailable({required String? productId, required String? pharmacyId}) async {
    await cartRepo.notifyMeWhenAvailable(productId: productId, pharmacyId: pharmacyId);
  }
}
