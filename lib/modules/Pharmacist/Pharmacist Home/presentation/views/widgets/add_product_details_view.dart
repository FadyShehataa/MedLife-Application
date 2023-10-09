import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Home/data/models/add_product_model/add_product_model.dart';
import '../../../../../../core/utils/constants.dart';

import 'add_product_details_view_body.dart';

class AddProductDetailsView extends StatelessWidget {
  const AddProductDetailsView({Key? key, required this.addProductModel})
      : super(key: key);

  final AddProductModel addProductModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AddProductDetailsViewBody(
          addProductModel: addProductModel,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.myBlack),
      ),
    );
  }
}
