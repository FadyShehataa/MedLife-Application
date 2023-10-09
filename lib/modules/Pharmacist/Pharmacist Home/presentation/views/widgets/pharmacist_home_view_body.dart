import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Home/presentation/views/widgets/pharmacist_home_search_section.dart';
import '../../../../Pharmacist%20Home/presentation/views/widgets/pharmacist_products_section.dart';

class PharmacistHomeViewBody extends StatelessWidget {
  const PharmacistHomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top:  8 ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            PharmacistHomeSearchSection(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pharmacy Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Expanded(
              child: PharmacistProductsSection(),
            ),
          ],
        ),
      ),
    );
  }
}
