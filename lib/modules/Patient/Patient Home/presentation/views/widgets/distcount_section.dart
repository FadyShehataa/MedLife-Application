import 'package:flutter/material.dart';
import '../../../../../../main.dart';

class DiscountSection extends StatelessWidget {
  const DiscountSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MyApp.isMobile) ? 100 : 150,
      height: (MyApp.isMobile) ? 200 : 300,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/Medicine.jpg",
            fit: BoxFit.fill,
          ),
          Positioned(
              top: 40,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3)),
                child:  Row(
                  children: [
                    Text("25",
                        style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Column(
                      children: [
                        Text("%",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text(" OFF",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
