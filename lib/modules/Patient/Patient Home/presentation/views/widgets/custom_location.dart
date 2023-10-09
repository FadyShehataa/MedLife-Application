import 'package:flutter/material.dart';
import '../../../../../../main.dart';
import '../../../../Patient%20Home/presentation/views/widgets/rating_dialog.dart';

class CustomLocation extends StatelessWidget {
  const CustomLocation({
    Key? key,
    this.pharmacyId,
  }) : super(key: key);
  final String? pharmacyId;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MyApp.isMobile) ? 100 : 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 0,
            child: Image.asset(
              "assets/images/MedicineDeliver.jpg",
              fit: BoxFit.fill,
              width: 250,
              height: 200,
            ),
          ),
          Positioned(
              top: 70,
              left: (MyApp.isMobile) ? 0 : 20,
              child: const Text(
                " We Will deliver \n you medicines",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Positioned(
            top: 10,
            right: (MyApp.isMobile) ? 5 : 20,
            child: TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => RatingDialog(pharmacyId: pharmacyId!),
                );
              },
              label: const Text("Leave a rating"),
              icon: const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ),
          )
        ],
      ),
    );
  }
}
