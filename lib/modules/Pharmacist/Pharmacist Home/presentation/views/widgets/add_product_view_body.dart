import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Home/presentation/views/widgets/products_section.dart';

import 'add_product_search_section.dart';

class AddProductViewBody extends StatelessWidget {
  AddProductViewBody({Key? key}) : super(key: key);

  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            AddProductSearchSection(),
            const SizedBox(height: 20),
            const Expanded(
              child: ProductsSection(),
            ),
          ],
        ),
      ),
    );
  }
}
