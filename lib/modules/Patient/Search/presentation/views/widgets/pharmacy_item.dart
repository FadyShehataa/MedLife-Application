import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../Patient%20Home/data/models/pharmacy_model/pharmacy_model.dart';
import '../../../../Patient%20Home/presentation/manager/pharmacy_products_cubit/pharmacy_products_cubit.dart';
import '../../../../patient_main_view.dart';

import '../../../../../../core/utils/constants.dart';

class SearchPharmacyItem extends StatelessWidget {
  const SearchPharmacyItem({Key? key, required this.pharmacyModel})
      : super(key: key);

  final PharmacyModel pharmacyModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(pharmacyModel.pharmacistImage ??
                        'assets/images/pharmacies/s6.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pharmacyModel.name!,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: pharmacyModel.rating?.toDouble() ?? 0,
                    itemSize: 30,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color(0xffffe234),
                    ),
                    onRatingUpdate: (rating) {
                      if (kDebugMode) {
                        print(rating);
                      }
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.myBlue,  //Colors.blue,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<PharmacyProductsCubit>(context)
                          .fetchPharmacyProducts(
                              pharmacyID: pharmacyModel.id!);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => PatientMainView(7, pharmacyModel),
                        ),
                      );
                    },
                    child: const Text(
                      'Go To Pharmacy',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
