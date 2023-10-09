import 'package:flutter/material.dart';
import '../../../../OnBoarding/onboarding_screen.dart';
import '../../../../PATIENT/patient_main_view.dart';
import '../../../../PHARMACIST/Pharmacist_main_view.dart';
import '../../../../Resignation/presentation/views/auth_main_view.dart';
import 'sliding_text.dart';
import '../../../../../core/utils/constants.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //assets/images/pills.png
        Image.asset('assets/images/medlife_logo2.png'),
        const SizedBox(
          height: 4,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              if(onBoard != null && onBoard == 'false' && appMode?.userType == 'patient') {
                return PatientMainView();
              } else if (onBoard != null && onBoard == 'false' && appMode?.userType == 'pharmacist') {
                return PharmacistMainView();
              } else if (onBoard != null && onBoard == 'false'){
                return const AuthMainView();
              } else {
                return const OnBoardingScreenView();
              }
            },
          ),
        );
      },
    );
  }
}
