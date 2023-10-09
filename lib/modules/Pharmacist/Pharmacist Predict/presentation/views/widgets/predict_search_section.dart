import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_search.dart';
import '../../../../Pharmacist%20Predict/presentation/manager/cubit/pharmacist_predict_cubit.dart';

class PredictSearchSection extends StatelessWidget {
  PredictSearchSection({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomSearch(
      readonly: false,
      autofocus: false,
      controller: searchController,
      hintText: 'search predict drugs',
      suffixIconButton: IconButton(
        onPressed: () {
          BlocProvider.of<PharmacistPredictCubit>(context)
              .searchPredictProductsQuery(searchController.text);
        },
        icon: const Icon(Icons.search, color: Color(0xffa09fa0)),
      ),
      onSubmitted: (_) {
        BlocProvider.of<PharmacistPredictCubit>(context)
            .searchPredictProductsQuery(searchController.text);
      },
    );
  }
}
