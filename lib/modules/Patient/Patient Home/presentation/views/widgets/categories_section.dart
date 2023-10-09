import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../Patient%20Home/presentation/views/categories_view.dart';

import '../../manager/categories_cubit/categories_cubit.dart';
import 'category_item.dart';
import 'custom_title.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({Key? key}) : super(key: key);

  final List<String> categoryNames = [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoriesCubit>(context).categories.forEach((category) {
      categoryNames.add(category.name ?? "");
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTitle(text: "Categories"),
            TextButton(
              onPressed: () {
                BlocProvider.of<CategoriesCubit>(context).selectCategory = 0;

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoriesView(),
                  ),
                );
              },
              child: const Text('See All'),
            )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 36,
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
            if (state is CategoriesSuccess || state is CategoriesProductsSelect) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    category: BlocProvider.of<CategoriesCubit>(context).categories[index],
                    categoryIndex: index + 1,
                  );
                },
                itemCount: BlocProvider.of<CategoriesCubit>(context).categories.length,
              );
            } else if (state is CategoriesFailure) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else if (state is CategoriesLoading) {
              return const CustomLoadingIndicator();
            }
            return Container();
          }),
        ),
      ],
    );
  }
}
