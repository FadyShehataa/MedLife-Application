import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../manager/search_cubit/search_cubit.dart';
import 'pharmacy_item.dart';

class SearchPharmaciesResultSection extends StatelessWidget {
  const SearchPharmaciesResultSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is SearchPharmacySuccess) {
        if (state.pharmacies.isNotEmpty) {
          return ListView.separated(
            itemBuilder: (context, index) =>
                SearchPharmacyItem(pharmacyModel: state.pharmacies[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: state.pharmacies.length,
          );
        } else {
          return const CustomEmptyWidget(
            image: 'assets/images/Empty_Cart.png',
            title: 'No Result Found',
            subTitle: "There isn't pharmacy with this name",
          );
        }
      } else if (state is SearchFailure) {
        return CustomErrorWidget(errMessage: state.errMessage);
      } else if (state is SearchLoading) {
        return const CustomLoadingIndicator();
      }
      return Container();
    });
  }
}
