import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../../Pharmacist%20Home/data/models/add_product_model/add_product_model.dart';
import '../../../../Pharmacist%20Home/presentation/views/widgets/add_product_details_view.dart';
import '../../../../../../core/utils/constants.dart';


class AddProductItem extends StatelessWidget {
  const AddProductItem({Key? key, required this.addProductModel})
      : super(key: key);

  final AddProductModel addProductModel;

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
                    imageUrl: addProductModel.images![0].url!,
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
                      addProductModel.name!,
                      style: const TextStyle(color: MyColors.myGrey),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      addProductModel.type!,
                      style: const TextStyle(color: MyColors.myGrey),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      addProductModel.description![0],
                      style: const TextStyle(color: MyColors.myGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(flex: 3),
                    CustomElevatedButton(
                      radius: 8,
                      child: const Text('Add to Pharmacy'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return AddProductDetailsView(
                              addProductModel: addProductModel,
                            );
                          }),
                        );
                      },
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
