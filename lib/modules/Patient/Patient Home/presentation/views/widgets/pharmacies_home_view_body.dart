import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_search.dart';
import '../../../../Patient%20Home/presentation/views/widgets/patient_info_section.dart';
import '../../../../Patient%20Home/presentation/views/widgets/pharmacies_section.dart';
import '../../../../Prescription%20OCR/presentation/views/prescription_view.dart';
import '../../../../Search/presentation/manager/filter_search_cubit/filter_search_cubit.dart';
import '../../../../Search/presentation/views/search_view.dart';

import 'distcount_section.dart';

class PharmaciesHomeViewBody extends StatelessWidget {
  const PharmaciesHomeViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            const PatientInfoSection(),
            CustomSearch(
              hintText: 'Search',
              onTap: () {
                BlocProvider.of<FilterSearchCubit>(context)
                    .filterState(filterName: 'Find Pharmacy');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const SearchView()),
                  ),
                );
              },
              suffixIconButton: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrescriptionView(),
                    ),
                  );
                },
                icon: const Icon(Icons.document_scanner_outlined,
                    color: Color(0xffa09fa0)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: const [
                  DiscountSection(),
                  SizedBox(height: 20),
                  PharmaciesSection(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
