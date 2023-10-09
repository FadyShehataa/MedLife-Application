import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../../../main.dart';
import '../../../../Prescription%20OCR/presentation/views/prescription_result_item.dart';
import '../../manager/search_cubit/search_cubit.dart';

class SearchProductInPharmaciesResultSection extends StatelessWidget {
  const SearchProductInPharmaciesResultSection({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is SearchProductInPharmaciesSuccess) {
        if (state.products.isNotEmpty) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: ((context, index) {
              return PrescriptionResultItem(
                prescriptionModel: state.products[index],
                scale: MyApp.isMobile ? 1 : 1.5 * 0.75,
              );
            }),
          );
        } else {
          return const CustomEmptyWidget(
            image: 'assets/images/Empty_Cart.png',
            title: 'No Result Found',
            subTitle: "There isn't product with this name",
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
