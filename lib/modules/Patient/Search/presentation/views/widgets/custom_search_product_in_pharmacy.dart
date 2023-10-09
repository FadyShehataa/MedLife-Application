import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_search.dart';
import '../../manager/search_cubit/search_cubit.dart';

class CustomSearchProductInPharmacy extends StatelessWidget {
  CustomSearchProductInPharmacy({
    Key? key,
    required this.pharmacyId,
  }) : super(key: key);

  final String pharmacyId;

  final TextEditingController searchProductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomSearch(
      readonly: false,
      hintText: 'Find Product',
      controller: searchProductController,
      prefixIconButton: IconButton(
        onPressed: () => BlocProvider.of<SearchCubit>(context)
            .fetchProductInPharmacy(
                pharmacyId: pharmacyId,
                productName: searchProductController.text),
        icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
      ),
      onSubmitted: (_) => BlocProvider.of<SearchCubit>(context)
          .fetchProductInPharmacy(
              pharmacyId: pharmacyId,
              productName: searchProductController.text),
    );
  }
}
