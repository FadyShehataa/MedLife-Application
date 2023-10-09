import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants.dart';

class PatientInfoSection extends StatelessWidget {
  const PatientInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: (MyApp.isMobile) ? 160 : 180,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
               SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: CachedNetworkImage(
                    imageUrl: mainPatient!.imageURL!,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 40,
                    ),
                    // placeholder: (context, url) => const CustomLoadingIndicator(),
                  ),
                ),

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: '  Hello ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: mainPatient!.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
