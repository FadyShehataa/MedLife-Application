import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Pharmacist%20Predict/presentation/views/widgets/SalesChart.dart';
import '../../../Pharmacist%20Predict/presentation/manager/cubit/pharmacist_predict_cubit.dart';

class DrugPredictionView extends StatefulWidget {
  DrugPredictionView({
    Key? key,
    required this.drug,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);
  final num drug;
  DateTime? startDate;
  DateTime? endDate;
  @override
  State<DrugPredictionView> createState() => _DrugPredictionViewState();
}

class _DrugPredictionViewState extends State<DrugPredictionView> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Sales chart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SalesChart(startDate: widget.startDate, endDate: widget.endDate),
    );
  }

  Future<void> fetchData() async {
    await BlocProvider.of<PharmacistPredictCubit>(context)
        .fetchDrugPrediction(bodyRequest: {
      "start_date": DateFormat('yyyy-MM-dd').format(widget.startDate!),
      "end_date": DateFormat('yyyy-MM-dd').format(widget.endDate!),
      "drug": widget.drug,
    });
  }
}
