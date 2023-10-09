import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../models/cart_model/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, List<CartModel>>> fetchCart();
  Future<Either<Failure, List<CartModel>>> deleteItemFromCart(
      {required String cartID, required String quantity});
  Future<Either<Failure, List<CartModel>>> decreaseItemFromCart(
      {required String cartID});
  Future<Either<Failure, List<CartModel>>> addItemToCart(
      {required String cartID});

  Future<Either<Failure, void>> orderCart({dynamic bodyRequest});

  Future<Either<Failure, void>> notifyMeWhenAvailable(
      {dynamic productId, dynamic pharmacyId});
}
