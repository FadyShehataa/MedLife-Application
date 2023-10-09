import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../Pharmacist%20Home/data/models/pharmacist_product_model/pharmacist_product_model.dart';
import '../../../../Pharmacist%20Home/presentation/manager/pharmacist_product_cubit/pharmacist_product_cubit.dart';
import '../../../../Pharmacist%20Home/presentation/views/widgets/pharmacist_product_item.dart';

import '../../../../../../core/widgets/custom_empty_widget.dart';

class PharmacistProductsSection extends StatelessWidget {
  const PharmacistProductsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacistProductCubit, PharmacistProductState>(
      builder: (context, state) {
        if (state is PharmacistProductSuccess || state is SearchQueryState) {
          if (BlocProvider.of<PharmacistProductCubit>(context)
              .pharmacyProducts
              .isNotEmpty) {
            // ignore: prefer_function_declarations_over_variables
            bool Function(PharmacistProductModel) startsWith =
                (PharmacistProductModel search) {
              return search.product!.name!.toLowerCase().startsWith(
                  BlocProvider.of<PharmacistProductCubit>(context)
                      .searchPharmacyProductsController
                      .text
                      .toLowerCase());
            };
            List<PharmacistProductModel> filterList =
                BlocProvider.of<PharmacistProductCubit>(context)
                    .pharmacyProducts
                    .where(startsWith)
                    .toList();

            if (filterList.isNotEmpty) {
              return ListView.builder(
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return PharmacistProductItem(
                    pharmacistProductModel: filterList[index],
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          } else {
            return const CustomEmptyWidget(
              image: "assets/images/Empty_Cart.png",
              title: 'No Products Yet!',
              subTitle: 'Start Adding some products',
            );
          }
        } else if (state is PharmacistProductFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else if (state is PharmacistProductLoading) {
          return const CustomLoadingIndicator();
        }
        return Container();
      },
    );
  }
}
