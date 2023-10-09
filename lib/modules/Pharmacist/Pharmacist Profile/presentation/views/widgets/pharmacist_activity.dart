import 'package:flutter/material.dart';
import '../../../../Pharmacist_main_view.dart';
import '../../../../../../core/utils/constants.dart';

import '../../../../../../core/utils/Controllers/Chat/SocketConnection.dart';
import '../../../../../PATIENT/Patient Profile/presentation/views/widgets/patient_activity_item.dart';
import '../../../../../PATIENT/Patient Profile/presentation/views/widgets/separate_widget.dart';
import '../../../../../Resignation/presentation/views/auth_main_view.dart';

class PharmacistActivity extends StatelessWidget {
  PharmacistActivity({Key? key}) : super(key: key);
  SocketConnection socketConnection = SocketConnection.getObj();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          PatientActivityItem(
            height: height,
            width: width,
            text: "Edit Profile",
            icon: Icons.edit,
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PharmacistMainView(5)));
            },
            trailing: Icons.arrow_forward_ios_rounded,
          ),
          const SeparateWidget(),
          PatientActivityItem(
              height: height,
              width: width,
              text: "Home",
              icon: Icons.home,
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PharmacistMainView(0)));
              },
              trailing: Icons.arrow_forward_ios_rounded),
          const SeparateWidget(),
          PatientActivityItem(
            height: height,
            text: 'Orders',
            width: width,
            icon: Icons.receipt,
            trailing: Icons.arrow_forward_ios_rounded,
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PharmacistMainView(1)));
            },
          ),
          const SeparateWidget(),
          PatientActivityItem(
              height: height,
              text: 'Add product',
              width: width,
              icon: Icons.add,
              trailing: Icons.arrow_forward_ios_rounded,
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PharmacistMainView(2)));
              }),
          const SeparateWidget(),
          PatientActivityItem(
            height: height,
            text: 'Chat',
            width: width,
            icon: Icons.chat,
            trailing: Icons.arrow_forward_ios_rounded,
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => PharmacistMainView(3)));
            },
          ),
          const SeparateWidget(),
          PatientActivityItem(
            height: height,
            text: 'Chart Forecasting',
            width: width,
            icon: Icons.bar_chart,
            trailing: Icons.arrow_forward_ios_rounded,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PharmacistMainView(-2)));
            },
          ),
          const SeparateWidget(),
          PatientActivityItem(
            height: height,
            width: width,
            text: "Logout",
            icon: Icons.logout_outlined,
            onTap: () async {
              socketConnection.disconnect();
              await deletePharmacistData();

              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const AuthMainView();
              }));
            },
            trailing: Icons.arrow_forward_ios_rounded,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Future<void> deletePharmacistData() async {
    mainPharmacist!.name = '';
    mainPharmacist!.email = '';
    mainPharmacist!.pharmacyName = '';
    mainPharmacist!.pharmacyImage = '';
    mainPharmacist!.pharmacyId = '';
    mainPharmacist!.id = '';
    mainPharmacist!.token = '';
    mainPharmacist!.lat = 0.0;
    mainPharmacist!.lng = 0.0;

    appMode!.userType = '';
    await appMode?.save();
  }
}
