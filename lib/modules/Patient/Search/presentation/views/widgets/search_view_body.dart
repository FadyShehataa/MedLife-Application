import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/filter_search_cubit/filter_search_cubit.dart';
import 'custom_search_pharmacy.dart';
import 'custom_search_product_in_pharmacy.dart';
import 'search_pharmacies_result_section.dart';
import 'search_product_in_pharmacies_result_section.dart';
import 'search_product_in_pharmacy_result_section.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({Key? key, this.pharmacyId}) : super(key: key);

  final String? pharmacyId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: BlocBuilder<FilterSearchCubit, FilterSearchState>(
          builder: (context, state) {
            if (state is FilterSearchPharmacies ||
                state is FilterSearchProductInPharmacies ||
                state is FindPharmacyType ||
                state is FindProductInNearestPharmacyType) {
              return Column(
                children: [
                  const CustomSearchPharmacy(),
                  const SizedBox(height: 20),
                  state is FilterSearchPharmacies
                      ? const Expanded(
                          child: SearchPharmaciesResultSection(),
                        )
                      : const Expanded(
                          child: SearchProductInPharmaciesResultSection(),
                        ),
                ],
              );
            } else if (state is FilterSearchProductInPharmacy) {
              return Column(
                children: [
                  CustomSearchProductInPharmacy(pharmacyId: pharmacyId!),
                  const SizedBox(height: 20),
                  const Expanded(
                    child: SearchProductInPharmacyResultSection(),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
