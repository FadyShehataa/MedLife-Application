import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Pharmacist%20Predict/presentation/views/widgets/pharmacist_predict_view_body.dart';

import '../manager/cubit/pharmacist_predict_cubit.dart';

class PharmacistPredictView extends StatefulWidget {
  const PharmacistPredictView({Key? key}) : super(key: key);

  @override
  State<PharmacistPredictView> createState() => _PharmacistPredictViewState();
}

class _PharmacistPredictViewState extends State<PharmacistPredictView> {
  @override
  void initState() {
    super.initState();
    fetchPredictProducts();
  }

  Future<void> fetchPredictProducts() async {
    await BlocProvider.of<PharmacistPredictCubit>(context)
        .fetchPredictProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drug Forecasting',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: PharmacistPredictViewBody(),
      ),
    );
  }
}
