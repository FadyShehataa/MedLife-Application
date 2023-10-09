import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Pharmacist%20Home/presentation/manager/pharmacist_product_cubit/pharmacist_product_cubit.dart';

import '../../../../../../core/widgets/custom_search.dart';

class PharmacistHomeSearchSection extends StatelessWidget {
  PharmacistHomeSearchSection({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacistProductCubit, PharmacistProductState>(
      builder: (context, state) {
        return CustomSearch(
          autofocus: false,
          readonly: false,
          controller: searchController,
          hintText: 'Search Product..',
          suffixIconButton: IconButton(
            onPressed: () {
              BlocProvider.of<PharmacistProductCubit>(context)
                  .searchPharmacyProductsQuery(searchController.text);
            },
            icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
          ),
          onSubmitted: (_) {
            BlocProvider.of<PharmacistProductCubit>(context)
                .searchPharmacyProductsQuery(searchController.text);
          },
        );
      },
    );
  }
}
