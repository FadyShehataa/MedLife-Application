import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';

import '../models/pharmacist_order/pharmacist_order.dart';

abstract class PharmacistOrderRepo {
  Future<Either<Failure, List<PharmacistOrderModel>>> fetchPharmacistOrders();

  Future<Either<Failure, void>> confirmPharmacistOrder(
      {dynamic bodyRequest, String? orderId});
}
