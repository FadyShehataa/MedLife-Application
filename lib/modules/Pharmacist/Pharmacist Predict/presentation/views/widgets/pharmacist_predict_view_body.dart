import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Predict/presentation/views/widgets/predict_products_section.dart';
import '../../../../Pharmacist%20Predict/presentation/views/widgets/predict_search_section.dart';

class PharmacistPredictViewBody extends StatelessWidget {
  PharmacistPredictViewBody({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            PredictSearchSection(),
            const SizedBox(height: 20),
            const PredictProductsSection()
          ],
        ),
      ),
    );
  }
}
