import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import 'login_patient_view.dart';
import 'login_pharmacist_view.dart';

class AuthMainView extends StatelessWidget {
  const AuthMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              flex: MyApp.isMobile ? 3 : 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MyApp.isMobile ? 0.0 : width * 0.15,
                ),
                child: const Image(
                  image: AssetImage('assets/images/start_image/start_page.png'),
                  filterQuality: FilterQuality.high,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MyApp.isMobile ? 30.0 : width * 0.08),
                    child: CustomElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginPatientView(),
                          ),
                        );
                      },
                      radius: 8,
                      child: const Text(
                        'Patient',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MyApp.isMobile ? 30.0 : width * 0.08),
                    child: CustomElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginPharmacistView(),
                          ),
                        );
                      },
                      radius: 8,
                      child: const Text(
                        'Pharmacist',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
