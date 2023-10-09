import 'package:flutter/material.dart';
import '../../../Pharmacist%20Profile/presentation/views/widgets/pharmacist_profile_view_body.dart';

class PharmacistProfileView extends StatelessWidget {
  const PharmacistProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: PharmacistProfileViewBody(),
      ),
    );
  }
}
