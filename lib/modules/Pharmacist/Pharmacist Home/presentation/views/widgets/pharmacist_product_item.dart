import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../../Pharmacist%20Home/data/models/pharmacist_product_model/pharmacist_product_model.dart';
import '../../../../Pharmacist%20Home/presentation/views/widgets/pharmacist_products_edit_view.dart';

import '../../../../../../core/utils/constants.dart';
import '../../manager/pharmacist_product_cubit/pharmacist_product_cubit.dart';

class PharmacistProductItem extends StatelessWidget {
  const PharmacistProductItem({Key? key, required this.pharmacistProductModel})
      : super(key: key);

  final PharmacistProductModel pharmacistProductModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: MyColors.myBackGround2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 3.35 / 3.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: pharmacistProductModel.product!.images![0],
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      pharmacistProductModel.product!.name!,
                      style:
                          const TextStyle(color: MyColors.myGrey, fontSize: 18),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      pharmacistProductModel.product!.type!,
                      style: const TextStyle(color: MyColors.myGrey),
                    ),
                    const Spacer(flex: 3),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            radius: 6,
                            child: const Text('Edit'),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return PharmacistProductsEditView(
                                    pharmacistProductModel:
                                        pharmacistProductModel,
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomElevatedButton(
                            radius: 6,
                            onPressed: () {
                              BlocProvider.of<PharmacistProductCubit>(context)
                                  .deletePharmacyProduct(bodyRequest: {
                                "pharmacyId": pharmacistProductModel.pharmacy,
                                "productId": pharmacistProductModel.id,
                                "amount": "0",
                                "price":
                                    pharmacistProductModel.price.toString(),
                              });
                            },
                            backgroundColor: Colors.red,
                            child: const Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
