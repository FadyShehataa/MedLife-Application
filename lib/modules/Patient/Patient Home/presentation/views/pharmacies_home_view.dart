import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Patient%20Home/presentation/manager/pharmacies_cubit/pharmacies_cubit.dart';
import '../../../Patient%20Home/presentation/views/widgets/pharmacies_home_view_body.dart';

import '../manager/pharmacies_cubit/best_pharmacies_cubit.dart';

class PharmaciesHomeView extends StatefulWidget {
  const PharmaciesHomeView({Key? key}) : super(key: key);

  @override
  State<PharmaciesHomeView> createState() => _PharmaciesHomeViewState();
}

class _PharmaciesHomeViewState extends State<PharmaciesHomeView> {
  @override
  void initState() {
    super.initState();
    fetchPharmacies();
    fetchBestPharmacies();
  }

  void fetchPharmacies() async {
    await BlocProvider.of<PharmaciesCubit>(context).fetchPharmacies();
  }

  void fetchBestPharmacies() async {
    await BlocProvider.of<BestPharmaciesCubit>(context).fetchBestPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: PharmaciesHomeViewBody(),
      ),
    );
  }
}
