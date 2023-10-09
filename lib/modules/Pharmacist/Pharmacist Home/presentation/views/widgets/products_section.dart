import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../Pharmacist%20Home/data/models/add_product_model/add_product_model.dart';
import '../../../../Pharmacist%20Home/presentation/manager/add_product_cubit/add_product_cubit.dart';

import '../../../../Pharmacist Home/presentation/manager/pharmacist_product_cubit/pharmacist_product_cubit.dart';
import 'add_product_item.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        if (state is AddProductSuccess || state is SearchQueryAddProductState) {
          // ignore: prefer_function_declarations_over_variables
          bool Function(AddProductModel) startsWith = (AddProductModel search) {
            return search.name!.toLowerCase().startsWith(
                BlocProvider.of<AddProductCubit>(context)
                    .searchAddProductController
                    .text
                    .toLowerCase());
          };
          List filterList = BlocProvider.of<AddProductCubit>(context)
              .systemProducts
              .where(startsWith)
              .toList();

          if (filterList.isNotEmpty) {
            filterList = filterList
                .where((element1) =>
                    !(BlocProvider.of<PharmacistProductCubit>(context)
                            .pharmacyProducts)
                        .any((element2) => element1.id == element2.product!.id))
                .toList();

            if (BlocProvider.of<AddProductCubit>(context)
                .systemProducts
                .where(
                  (element1) => !(BlocProvider.of<PharmacistProductCubit>(
                              context)
                          .pharmacyProducts)
                      .any((element2) => element1.id == element2.product!.id),
                )
                .isEmpty) {
              return const CustomEmptyWidget(
                image: "assets/images/Empty_Cart.png",
                title: 'No Products Yet!',
                subTitle: 'System  is empty now',
              );
            } else {
              return ListView.builder(
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return AddProductItem(
                    addProductModel: filterList[index],
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        } else if (state is AddProductFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else if (state is AddProductLoading) {
          return const CustomLoadingIndicator();
        }
        return Container();
      },
    );
  }
}
