import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_empty_widget.dart';
import '../../../../../main.dart';
import '../../../Patient%20Home/data/models/pharmacy_product_model/pharmacy_product_model.dart';
import '../../../Patient%20Home/presentation/manager/categories_cubit/categories_cubit.dart';
import '../../../Patient%20Home/presentation/manager/pharmacy_products_cubit/pharmacy_products_cubit.dart';
import '../../../Patient%20Home/presentation/views/widgets/category_product_item.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({Key? key}) : super(key: key);


 final List<String> categoryNames = ['All'];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoriesCubit>(context).categories.forEach((category) {
      categoryNames.add(category.name ?? "");
    });


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  7,
                  (position) {
                    return BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, index) => GestureDetector(
                        onTap: () async {
                          BlocProvider.of<CategoriesCubit>(context)
                              .selectCategoryQuery(position);
                        },
                        child: Container(
                          height: 36,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            color: position ==
                                    BlocProvider.of<CategoriesCubit>(context)
                                        .selectCategory
                                ? Colors.lightBlue
                                : Colors.grey[400],
                          ),
                          child: Text(
                            categoryNames[position],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, index) {
                List<PharmacyProductModel> allProducts =
                    BlocProvider.of<PharmacyProductsCubit>(context)
                        .pharmacyProducts;
                if (BlocProvider.of<CategoriesCubit>(context).selectCategory !=
                    0) {
                  allProducts = allProducts.where(
                    (element) {
                      return element.product!.type!.toLowerCase() ==
                          categoryNames[
                                  BlocProvider.of<CategoriesCubit>(context)
                                      .selectCategory]
                              .toLowerCase();
                    },
                  ).toList();
                }
                if (allProducts.isNotEmpty) {
                  return Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        itemCount: allProducts.length,
                        itemBuilder: ((context, index) {
                          return CategoryProductItem(
                            pharmacyProductModel: allProducts[index],
                            scale: MyApp.isMobile ? 1 : 1.5 * 0.75,
                          );
                        }),
                      ),
                    ),
                  );
                } else {
                  return const CustomEmptyWidget(
                    image: 'assets/images/Empty_Cart.png',
                    title: 'No Products Yet !',
                    subTitle: 'There is no Product in this category',
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
