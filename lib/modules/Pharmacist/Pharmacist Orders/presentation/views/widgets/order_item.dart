import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../data/models/pharmacist_order/pharmacist_order.dart';
import '../../../../Pharmacist%20Orders/presentation/manager/pharmacist_order_cubit/pharmacist_orders_cubit.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final PharmacistOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Patient Name',
                          style: TextStyle(color: Color(0xffb0b2bc)),
                        ),
                        Text(order.purchaser!.name!),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deliver To',
                          style: TextStyle(color: Color(0xffb0b2bc)),
                        ),
                        Text(order.purchaser!.address!),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Payment',
                          style: TextStyle(color: Color(0xffb0b2bc)),
                        ),
                        Text('${order.totalPrice.toString()} EGP'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpandablePanel(
                      controller: ExpandableController(initialExpanded: true),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                      ),
                      header: const Text(
                        'Items',
                        style: TextStyle(fontSize: 18),
                      ),
                      collapsed: Column(
                        children: [
                          for (final item in order.items!)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, bottom: 8),
                              child: Row(
                                children: [
                                  const Text("\u2022  "),
                                  Text(item.product!.name!),
                                  const SizedBox(width: 6),
                                  Text('       ${item.quantity} quantity'),
                                ],
                              ),
                            ),
                        ],
                      ),
                      expanded: const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                order.status == 'WAITING'
                    ? Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              radius: 6,
                              child: const Text(
                                'Accept',
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                BlocProvider.of<PharmacistOrdersCubit>(context)
                                    .confirmPharmacistOrder(
                                  bodyRequest: {"status": "accepted"},
                                  orderId: order.id!,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomElevatedButton(
                              radius: 6,
                              onPressed: () {
                                BlocProvider.of<PharmacistOrdersCubit>(context)
                                    .confirmPharmacistOrder(
                                  bodyRequest: {"status": "rejected"},
                                  orderId: order.id!,
                                );
                              },
                              backgroundColor: Colors.red,
                              child: const Text(
                                'Reject',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              radius: 6,
                              onPressed: null,
                              // backgroundColor: Colors.grey,
                              child: Text(
                                // order.status!.toLowerCase(),
                                order.status!.substring(0, 1).toUpperCase() +
                                    order.status!.substring(1).toLowerCase(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
