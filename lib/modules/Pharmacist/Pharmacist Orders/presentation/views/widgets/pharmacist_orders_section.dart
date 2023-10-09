import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../Pharmacist%20Orders/data/models/pharmacist_order/pharmacist_order.dart';
import '../../../../Pharmacist%20Orders/presentation/views/widgets/order_item.dart';

import '../../manager/pharmacist_order_cubit/pharmacist_orders_cubit.dart';

class PharmacistOrdersSection extends StatelessWidget {
  const PharmacistOrdersSection({Key? key, required this.orderStatus})
      : super(key: key);

  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacistOrdersCubit, PharmacistOrdersState>(
      builder: (context, state) {
        if (state is PharmacistOrdersSuccess || state is SearchQueryState) {
          if (BlocProvider.of<PharmacistOrdersCubit>(context)
              .orders
              .isNotEmpty) {
            List<PharmacistOrderModel> filterList =
                BlocProvider.of<PharmacistOrdersCubit>(context).orders;
            if (BlocProvider.of<PharmacistOrdersCubit>(context).orderStatus !=
                '') {
              filterList = filterList
                  .where(
                    (element) =>
                        element.status!.toLowerCase() ==
                        BlocProvider.of<PharmacistOrdersCubit>(context)
                            .orderStatus
                            .toLowerCase(),
                  )
                  .toList();
            }
            if (filterList.isNotEmpty) {
              return ListView.builder(
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return OrderItem(
                    order: filterList[index],
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'There is no ${BlocProvider.of<PharmacistOrdersCubit>(context).orderStatus} Orders',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }
          } else {
            return const CustomEmptyWidget(
              image: "assets/images/Empty_Cart.png",
              title: 'No Orders Yet!',
              subTitle: 'There is no orders',
            );
          }
        } else if (state is PharmacistOrdersFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else if (state is PharmacistOrdersLoading) {
          return const CustomLoadingIndicator();
        }
        return Container();
      },
    );
  }
}
