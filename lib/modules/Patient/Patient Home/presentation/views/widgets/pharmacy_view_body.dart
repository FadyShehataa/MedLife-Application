import 'package:flutter/material.dart';
import '../../../../Patient%20Home/data/models/pharmacy_model/pharmacy_model.dart';
import '../../../../Patient%20Home/presentation/views/widgets/categories_section.dart';
import '../../../../Patient%20Home/presentation/views/widgets/custom_location.dart';
import '../../../../Patient%20Home/presentation/views/widgets/patient_info_section.dart';
import '../../../../Patient%20Home/presentation/views/widgets/pharmacy_products_section.dart';
import '../../../../Patient%20Home/presentation/views/widgets/search_section.dart';

class PharmacyViewBody extends StatelessWidget {
  const PharmacyViewBody({Key? key, required this.pharmacy}) : super(key: key);
  final PharmacyModel pharmacy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            const PatientInfoSection(),
            SearchSection(insidePharmacy: true, pharmacyName: pharmacy.id),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  CustomLocation(pharmacyId: pharmacy.id),
                  const SizedBox(height: 20),
                   CategoriesSection(),
                  const SizedBox(height: 20),
                  const PharmacyProductsSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
