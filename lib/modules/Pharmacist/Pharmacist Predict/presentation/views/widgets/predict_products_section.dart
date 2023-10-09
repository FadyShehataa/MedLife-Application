import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../Pharmacist%20Predict/data/models/predict_product_info_model.dart';
import '../../../../Pharmacist%20Predict/presentation/manager/cubit/pharmacist_predict_cubit.dart';
import '../../../../Pharmacist%20Predict/presentation/views/drug_prediction_view.dart';
import '../../../../../Resignation/presentation/views/widgets/show_snake_bar.dart';

import '../../../../../../core/utils/constants.dart';

class PredictProductsSection extends StatefulWidget {
  const PredictProductsSection({Key? key}) : super(key: key);

  @override
  State<PredictProductsSection> createState() => _PredictProductsSectionState();
}

class _PredictProductsSectionState extends State<PredictProductsSection> {
  var startdate = DateUtils.dateOnly((DateTime(2023, 7, 15)));

  var enddate = DateUtils.dateOnly((DateTime(2023, 7, 24)));
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PharmacistPredictCubit, PharmacistPredictState>(
        builder: (context, state) {
          if (state is PharmacistPredictSuccess || state is SearchQueryState) {
            if (BlocProvider.of<PharmacistPredictCubit>(context)
                .predictProducts
                .isNotEmpty) {
              // ignore: prefer_function_declarations_over_variables
              bool Function(PredictProductInfoModel) startsWith =
                  (PredictProductInfoModel search) {
                return search.name!.toLowerCase().startsWith(
                    BlocProvider.of<PharmacistPredictCubit>(context)
                        .searchPredictProductsController
                        .text
                        .toLowerCase());
              };
              List<PredictProductInfoModel> filterList =
                  BlocProvider.of<PharmacistPredictCubit>(context)
                      .predictProducts
                      .where(startsWith)
                      .toList();

              if (filterList.isNotEmpty) {
                return ListView.builder(
                  itemCount: filterList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(filterList[index].name!),
                        onTap: () {
                          var drug = filterList[index].number as num;

                          editDate(drug: drug);
                        },
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            } else {
              return const CustomEmptyWidget(
                image: "assets/images/Empty_Cart.png",
                title: 'No Products Yet!',
                subTitle: 'There is no products to predict',
              );
            }
          } else if (state is PharmacistPredictFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else if (state is PharmacistPredictLoading) {
            return const CustomLoadingIndicator();
          }
          return Container();
        },
      ),
    );
  }

  Future editDate({required var drug}) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          content: StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SizedBox(
                    height: height - 700,
                    width: width - 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Start Date",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2028),
                                  );
                                  if (newDate == null) return;
                                  setState(() => startdate = newDate);
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${startdate.day}-${startdate.month}-${startdate.year}"),
                                      const Icon(
                                        Icons.calendar_today,
                                        color: MyColors.myBlue,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "End Date",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: startdate,
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2028),
                                  );
                                  if (newDate == null) return;
                                  setState(() {
                                    enddate = DateUtils.dateOnly(newDate);
                                  });
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${enddate.day}-${enddate.month}-${enddate.year}"),
                                      const Icon(
                                        Icons.calendar_today,
                                        color: MyColors.myBlue,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          title: const Text("Enter Date to Show Sales Prediction"),
          actions: [
            TextButton(
                onPressed: () {
                  DateTime formattedStartDate = DateTime.parse(
                      DateFormat('yyyy-MM-dd').format(startdate));
                  DateTime formattedEndDate =
                      DateTime.parse(DateFormat('yyyy-MM-dd').format(enddate));

                  if (formattedEndDate.isBefore(formattedStartDate)) {
                    showSnackBar(
                        context, "End Date Can't be Before Start Date");
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DrugPredictionView(
                              startDate: startdate,
                              endDate: enddate,
                              drug: drug);
                        },
                      ),
                    );
                  }
                },
                child: const Text('SUBMIT'))
          ],
        ),
      );
}
