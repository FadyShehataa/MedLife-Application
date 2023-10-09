import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Patient%20Home/data/models/category_model/category_model.dart';
import '../../../../Patient%20Home/presentation/manager/categories_cubit/categories_cubit.dart';
import '../../../../Patient%20Home/presentation/views/categories_view.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    required this.categoryIndex,
  }) : super(key: key);

  final CategoryModel category;
  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.grey[400],
      ),
      child: TextButton(
        onPressed: () {
          BlocProvider.of<CategoriesCubit>(context).selectCategory =
              categoryIndex;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoriesView(),
            ),
          );
        },
        child: Text(
          category.name!,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
