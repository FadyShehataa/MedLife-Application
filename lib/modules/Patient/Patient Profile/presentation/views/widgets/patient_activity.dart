import 'package:flutter/material.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Profile/presentation/views/widgets/patient_activity_item.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Profile/presentation/views/widgets/patient_profile_view_body.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Profile/presentation/views/widgets/separate_widget.dart';
import '../../../../../../core/utils/Controllers/Chat/SocketConnection.dart';
import '../../../../../Resignation/presentation/views/auth_main_view.dart';
import '../../../../patient_main_view.dart';

class PatientActivity extends StatelessWidget {
  const PatientActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SocketConnection socketConnection = SocketConnection.getObj();

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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PatientMainView(5)));
            },
            trailing: Icons.arrow_forward_ios_rounded,
          ),
          const SeparateWidget(),
          PatientActivityItem(
            height: height,
            text: 'Favorites',
            width: width,
            icon: Icons.favorite,
            trailing: Icons.arrow_forward_ios_rounded,
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PatientMainView(1)));
            },
          ),
          const SeparateWidget(),
          PatientActivityItem(
              height: height,
              text: 'Cart',
              width: width,
              icon: Icons.shopping_cart_outlined,
              trailing: Icons.arrow_forward_ios_rounded,
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PatientMainView(2)));
              }),
          const SeparateWidget(),
          PatientActivityItem(
              height: height,
              width: width,
              text: "Chats",
              icon: Icons.chat_outlined,
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PatientMainView(6)));
              },
              trailing: Icons.arrow_forward_ios_rounded),
          const SeparateWidget(),
          PatientActivityItem(
            height: height,
            text: 'Reminder',
            width: width,
            icon: Icons.alarm,
            trailing: Icons.arrow_forward_ios_rounded,
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PatientMainView(3)));
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
              await deletePatientData();

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
}
