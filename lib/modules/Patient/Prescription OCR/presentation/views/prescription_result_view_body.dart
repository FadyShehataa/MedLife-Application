import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../../main.dart';
import '../../../Prescription%20OCR/presentation/manager/prescription_cubit/prescription_cubit.dart';
import '../../../Prescription%20OCR/presentation/views/prescription_result_item.dart';

class PrescriptionResultViewBody extends StatelessWidget {
  const PrescriptionResultViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrescriptionCubit, PrescriptionState>(
        builder: (context, state) {
      if (state is PrescriptionSuccess) {
        if (state.prescriptionProducts.isNotEmpty) {
          return ListView.builder(
            itemCount: state.prescriptionProducts.length,
            itemBuilder: ((context, index) {
              return PrescriptionResultItem(
                prescriptionModel: state.prescriptionProducts[index],
                scale: MyApp.isMobile ? 1 : 1.3 * 0.75,
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
      } else if (state is PrescriptionFailure) {
        return CustomErrorWidget(errMessage: state.errMessage);
      } else if (state is PrescriptionLoading) {
        return const CustomLoadingIndicator();
      }
      return Container();
    });
  }
}
