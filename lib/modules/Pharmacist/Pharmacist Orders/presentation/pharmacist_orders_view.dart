import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Pharmacist%20Orders/presentation/manager/pharmacist_order_cubit/pharmacist_orders_cubit.dart';
import '../../Pharmacist%20Orders/presentation/views/widgets/pharmacist_orders_section.dart';

import '../../../../core/utils/constants.dart';

class PharmacistOrdersView extends StatefulWidget {
  const PharmacistOrdersView({Key? key}) : super(key: key);

  @override
  State<PharmacistOrdersView> createState() => _PharmacistOrdersViewState();
}

class _PharmacistOrdersViewState extends State<PharmacistOrdersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String orderStatus = 'Accepted';

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    fetchPharmacistOrders();
  }

  Future<void> fetchPharmacistOrders() async {
    await BlocProvider.of<PharmacistOrdersCubit>(context)
        .fetchPharmacistOrders();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: MyColors.myBlue, //Colors.blue,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Pending'),
                    Tab(text: 'Accepted'),
                    Tab(text: 'Rejected'),
                  ],
                  onTap: (value) {
                    switch (value) {
                      case 0:
                        orderStatus = '';
                        break;
                      case 1:
                        orderStatus = 'Waiting';

                        break;
                      case 2:
                        orderStatus = 'Accepted';

                        break;
                      case 3:
                        orderStatus = 'Rejected';
                        break;
                      default:
                    }
                    BlocProvider.of<PharmacistOrdersCubit>(context)
                        .searchPharmacyProductsQuery(orderStatus);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PharmacistOrdersSection(orderStatus: orderStatus),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
