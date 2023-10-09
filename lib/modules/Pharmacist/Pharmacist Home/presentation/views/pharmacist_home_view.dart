import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Pharmacist%20Home/presentation/manager/pharmacist_product_cubit/pharmacist_product_cubit.dart';
import '../../../Pharmacist%20Home/presentation/views/widgets/pharmacist_home_view_body.dart';

import '../../../../../core/utils/constants.dart';

class PharmacistHomeView extends StatefulWidget {
  const PharmacistHomeView({Key? key}) : super(key: key);

  @override
  State<PharmacistHomeView> createState() => _PharmacistHomeViewState();
}

class _PharmacistHomeViewState extends State<PharmacistHomeView> {
  @override
  void initState() {
    super.initState();
    fetchPharmacyProducts();
  }

  Future<void> fetchPharmacyProducts() async {
    await BlocProvider.of<PharmacistProductCubit>(context)
        .fetchPharmacyProducts(pharmacyID: mainPharmacist!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: PharmacistHomeViewBody(),
      ),
    );
  }
}
