import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';

import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../manager/cubit/pharmacist_predict_cubit.dart';

class SalesChart extends StatelessWidget {
  SalesChart({Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  late double? average;
  late int? max;
  late int? min;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    double averageValue() {
      double sum = 0.0;
      for (int i = 0;
          i <
              BlocProvider.of<PharmacistPredictCubit>(context)
                  .drugPrediction
                  .predictedQuantity
                  .length;
          i++) {
        sum += BlocProvider.of<PharmacistPredictCubit>(context)
            .drugPrediction
            .predictedQuantity[i];
      }
      if (BlocProvider.of<PharmacistPredictCubit>(context)
          .drugPrediction
          .predictedQuantity
          .isNotEmpty) {
        return sum /
            BlocProvider.of<PharmacistPredictCubit>(context)
                .drugPrediction
                .predictedQuantity
                .length;
      }
      return 0.0;
    }

    int getMaxValue() {
      int max = 0;
      for (int i = 0;
          i <
              BlocProvider.of<PharmacistPredictCubit>(context)
                  .drugPrediction
                  .predictedQuantity
                  .length;
          i++) {
        if (BlocProvider.of<PharmacistPredictCubit>(context)
                .drugPrediction
                .predictedQuantity[i] >
            max) {
          max = BlocProvider.of<PharmacistPredictCubit>(context)
              .drugPrediction
              .predictedQuantity[i];
        }
      }
      return max;
    }

    int minValue() {
      int min = 0;
      for (int i = 0;
          i <
              BlocProvider.of<PharmacistPredictCubit>(context)
                  .drugPrediction
                  .predictedQuantity
                  .length;
          i++) {
        if (BlocProvider.of<PharmacistPredictCubit>(context)
                .drugPrediction
                .predictedQuantity[i] <
            min) {
          min = BlocProvider.of<PharmacistPredictCubit>(context)
              .drugPrediction
              .predictedQuantity[i];
        }
      }
      return min;
    }

    return BlocBuilder<PharmacistPredictCubit, PharmacistPredictState>(
        builder: (context, state) {
      if (state is PharmacistDrugPredictionLoading) {
        return const CustomLoadingIndicator();
      } else if (state is PharmacistDrugPredictionSuccess) {
        average = averageValue();

        max = getMaxValue();

        min = minValue();
        return Chart(
            startDate: startDate,
            endDate: endDate,
            average: average,
            max: max,
            min: min);
      } else if (state is PharmacistDrugPredictionFailure) {
        return CustomErrorWidget(errMessage: state.errMessage);
      }
      return Container();
    });
  }
}

class Chart extends StatefulWidget {
  Chart({
    Key? key,
    required this.average,
    required this.min,
    required this.max,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);
  double? average = 0.0;
  int? max = 1;
  int? min = 0;
  DateTime? startDate;
  DateTime? endDate;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: RotatedBox(quarterTurns: 1, child: Text("Quantity")),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.width * 1.5 * 0.65,
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Start Date",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                  "${widget.startDate!.day}-${widget.startDate!.month}-${widget.startDate!.year}")
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "End Date",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                  "${widget.endDate!.day}-${widget.endDate!.month}-${widget.endDate!.year}")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: BarChart(),
                      ),
                    ),
                    const Center(child: Text("Days")),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.width * 0.95 * 0.65,
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
            margin: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    title: const Text("Average Quantity"),
                    subtitle: Text(widget.average!.toStringAsFixed(2)),
                    leading: const Icon(Icons.medication),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text("Maximum Sold Quantity"),
                    subtitle: Text(widget.max.toString()),
                    leading: const Icon(Icons.medication),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text("Minimum Sold Quantity"),
                    subtitle: Text(widget.min.toString()),
                    leading: const Icon(Icons.medication),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ]);
  }
}

class BarChart extends StatelessWidget {
  BarChart({Key? key}) : super(key: key);
  List<BarChartModel> data = [];

  @override
  Widget build(BuildContext context) {
    dynamic quantity = BlocProvider.of<PharmacistPredictCubit>(context)
        .drugPrediction
        .predictedQuantity;
    dynamic days =
        BlocProvider.of<PharmacistPredictCubit>(context).drugPrediction.day;
    //loop over day and quantity and create BarChartModel
    for (int i = 0; i < quantity.length; i++) {
      data.add(BarChartModel(day: days[i].toString(), financial: quantity[i]));
    }

    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: data,
        domainFn: (BarChartModel series, _) => series.day,
        measureFn: (BarChartModel series, _) => series.financial,
        colorFn: (BarChartModel series, _) => (series.financial < 500)
            ? charts.ColorUtil.fromDartColor(Colors.lightBlueAccent)
            : charts.ColorUtil.fromDartColor(Colors.blueGrey),
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 500,
        child: charts.BarChart(
          series,
          animate: true,
        ),
      ),
    );
  }
}

class BarChartModel {
  String day;
  int financial;

  BarChartModel({
    required this.day,
    required this.financial,
  });
}
