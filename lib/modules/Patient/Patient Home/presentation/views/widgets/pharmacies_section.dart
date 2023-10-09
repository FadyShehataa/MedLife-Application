import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../Patient%20Home/presentation/manager/pharmacies_cubit/best_pharmacies_cubit.dart';
import '../../../../Patient%20Home/presentation/manager/pharmacies_cubit/pharmacies_cubit.dart';
import '../../../../Patient%20Home/presentation/views/widgets/pharmacy_item.dart';

import 'custom_title.dart';

class PharmaciesSection extends StatelessWidget {
  const PharmaciesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTitle(text: "Pharmacies"),
        const SizedBox(height: 10),
        BlocBuilder<PharmaciesCubit, PharmaciesState>(
            builder: (context, state) {
          if (state is PharmaciesSuccess) {
            return SizedBox(
              width: double.infinity,
              height: 250.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.pharmacies.length,
                itemBuilder: (context, index) => PharmacyItem(
                  pharmacy: state.pharmacies[index],
                ),
              ),
            );
          } else if (state is PharmaciesFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else if (state is PharmaciesLoading) {
            return const CustomLoadingIndicator();
          }
          return Container();
        }),
        const SizedBox(height: 20),
        const CustomTitle(text: "Best Pharmacies"),
        const SizedBox(height: 10),
        BlocBuilder<BestPharmaciesCubit, BestPharmaciesState>(
            builder: (context, state) {
          if (state is BestPharmaciesSuccess) {

            return SizedBox(
              width: double.infinity,
              height: 250.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.bestPharmacies.length,
                itemBuilder: (context, index) => PharmacyItem(
                  pharmacy: state.bestPharmacies[index],
                ),
              ),
            );
          } else if (state is BestPharmaciesFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else if (state is PharmaciesLoading) {
            return const CustomLoadingIndicator();
          }
          return Container();
        }),
      ],
    );
  }
}
