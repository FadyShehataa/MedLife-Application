import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../main.dart';
import '../../../../patient_main_view.dart';

import '../../../data/models/pharmacy_model/pharmacy_model.dart';
import '../../manager/pharmacy_products_cubit/pharmacy_products_cubit.dart';

class PharmacyItem extends StatelessWidget {
  PharmacyItem({
    Key? key,
    required this.pharmacy,
  }) : super(key: key);
  final PharmacyModel pharmacy;
  final double width = (MyApp.isMobile) ? 170 : 220;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PharmacyProductsCubit>(context)
            .fetchPharmacyProducts(pharmacyID: pharmacy.id!);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PatientMainView(7, pharmacy),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        padding: const EdgeInsets.all(10),
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: pharmacy.pharmacistImage == null
                      ? 'https://shorturl.at/gkAEP'
                      : pharmacy.pharmacistImage!,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 40,
                  ),
                  // placeholder: (context, url) => const CustomLoadingIndicator(),
                ),
              ),
              // child: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(4),
              //     color: MyColors.myWhite,
              //   ),
              //   child: pharmacy.pharmacistImage == null
              //       ? Image.asset("assets/images/profile_image/profile_2.png")
              //       : Image.network(pharmacy.pharmacistImage!),
              // ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // const SizedBox(width: 5),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pharmacy.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: RatingBar.builder(
                            ignoreGestures: true, // <---- add this
                            initialRating:
                                pharmacy.rating == null ? 0 : pharmacy.rating!,
                            minRating: 1,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 17.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (_) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  //const SizedBox(width: 5),
                  // Expanded(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       BlocProvider.of<PharmacyProductsCubit>(context)
                  //           .fetchPharmacyProducts(
                  //               pharmacyID: pharmacy.id!);

                  //       Navigator.of(context).pushReplacement(

                  //         MaterialPageRoute(
                  //           builder: (context) => PatientMainView(7, pharmacy),
                  //         ),
                  //       );
                  //     },
                  //     child: Container(
                  //       padding: const EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(30),
                  //         color: const Color(0xFF1982FC),
                  //         boxShadow: const [
                  //           BoxShadow(
                  //             blurRadius: 10,
                  //             color: Colors.grey,
                  //             offset: Offset(0, 5),
                  //           )
                  //         ],
                  //       ),
                  //       child: const Icon(
                  //         Icons.arrow_forward,
                  //         color: MyColors.myWhite,
                  //         size: 18,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
