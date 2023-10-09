import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../../Pharmacist%20Home/data/models/pharmacist_product_model/pharmacist_product_model.dart';
import '../../../../Pharmacist%20Home/presentation/manager/pharmacist_product_cubit/pharmacist_product_cubit.dart';
import '../../../../../Resignation/presentation/views/widgets/show_snake_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../PATIENT/Patient Home/presentation/views/widgets/custom_title.dart';

class PharmacistProductsEditViewBody extends StatelessWidget {
  PharmacistProductsEditViewBody(
      {Key? key, required this.pharmacistProductModel})
      : super(key: key);

  final PharmacistProductModel pharmacistProductModel;

  final _formKey = GlobalKey<FormState>();
  late final _priceController =
      TextEditingController(text: pharmacistProductModel.price.toString());
  late final _amountController =
      TextEditingController(text: pharmacistProductModel.amount.toString());
  final pageController = PageController(viewportFraction: 0.8, keepPage: true);
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacistProductCubit, PharmacistProductState>(
      listener: (context, state) {
        if (state is PharmacistProductLoading) {
          isLoading = true;
        } else if (state is PharmacistProductFailure) {
          showSnackBar(context, state.errMessage);

          isLoading = false;
        } else if (state is PharmacistProductSuccess) {
          Navigator.of(context).pop();
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                children: [
                  Container(
                    height: 300,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount:
                                pharmacistProductModel.product!.images!.length,
                            itemBuilder: (_, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.grey.shade300,
                                ),
                                child: SizedBox(
                                  height: 280,
                                  child: Center(
                                    child: Image.network(
                                      pharmacistProductModel
                                          .product!.images![index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SmoothPageIndicator(
                          controller: pageController,
                          count: pharmacistProductModel.product!.images!.length,
                          effect: const WormEffect(
                            dotHeight: 16,
                            dotWidth: 16,
                            type: WormType.thinUnderground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Price:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Price.';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 50),
                        const Text(
                          'Amount:',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Amount.';
                              } 
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await BlocProvider.of<PharmacistProductCubit>(context)
                            .editPharmacyProduct(bodyRequest: {
                          "pharmacyId": pharmacistProductModel.pharmacy,
                          "productId": pharmacistProductModel.id,
                          "amount": _amountController.text,
                          "price": _priceController.text
                        });
                      }
                    },
                    radius: 8,
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTitle(text: 'Details'),
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      return DetailsItem(
                        detailHeader: details[index],
                        detailCollapsed: jsonDecode(jsonEncode(
                                pharmacistProductModel.product))[details[index]]
                            .cast<String>()
                            .join('\n'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final List<String> details = [
    "description",
    "indication",
    "sideEffects",
    "dosage",
    "overdoseEffects",
    "precautions",
    "interactions",
    "storage"
  ];
}

class DetailsItem extends StatelessWidget {
  const DetailsItem({
    Key? key,
    required this.detailHeader,
    required this.detailCollapsed,
  }) : super(key: key);

  final String detailHeader;
  final String detailCollapsed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ExpandablePanel(
          controller: ExpandableController(initialExpanded: true),
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Text(
            detailHeader,
            style: const TextStyle(fontSize: 18),
          ),
          collapsed: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              detailCollapsed,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          expanded: const SizedBox(),
        ),
      ),
    );
  }
}
