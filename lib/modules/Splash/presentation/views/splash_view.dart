import 'package:flutter/material.dart';
import 'widgets/splash_view_body.dart';

import '../../../../core/widgets/custom_loading_indicator.dart';


class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    if(!isLoading) {
      return CustomLoadingIndicator();
    } else {
      return const Scaffold(
        body: SplashViewBody(),
      );
    }
  }
}
