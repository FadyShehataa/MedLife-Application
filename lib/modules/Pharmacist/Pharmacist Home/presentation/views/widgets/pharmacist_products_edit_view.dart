import 'package:flutter/material.dart';
import '../../../../Pharmacist%20Home/presentation/views/widgets/pharmacist_products_edit_view_body.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../data/models/pharmacist_product_model/pharmacist_product_model.dart';

class PharmacistProductsEditView extends StatelessWidget {
  const PharmacistProductsEditView(
      {Key? key, required this.pharmacistProductModel})
      : super(key: key);

  final PharmacistProductModel pharmacistProductModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PharmacistProductsEditViewBody(
          pharmacistProductModel: pharmacistProductModel,
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
