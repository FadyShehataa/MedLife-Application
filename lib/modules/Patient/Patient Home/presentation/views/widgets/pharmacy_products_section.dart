import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../../../main.dart';
import '../../../../Patient%20Home/presentation/manager/pharmacy_products_cubit/pharmacy_products_cubit.dart';
import '../../../../Patient%20Home/presentation/views/widgets/category_product_item.dart';

import 'custom_title.dart';

class PharmacyProductsSection extends StatelessWidget {
  const PharmacyProductsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTitle(text: "Best Deals"),
        const SizedBox(height: 10),
        BlocBuilder<PharmacyProductsCubit, PharmacyProductsState>(
            builder: (context, state) {
          if (state is PharmacyProductsSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.pharmacyProducts.length,
              itemBuilder: ((context, index) {
                return CategoryProductItem(
                  pharmacyProductModel: state.pharmacyProducts[index],
                  scale: MyApp.isMobile ? 1 : 1.5 * 0.75,
                );
              }),
            );
          } else if (state is PharmacyProductsFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else if (state is PharmacyProductsLoading) {
            return const CustomLoadingIndicator();
          }
          return Container();
        }),
      ],
    );
  }
}
