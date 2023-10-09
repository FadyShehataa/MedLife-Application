import 'package:flutter/animation.dart';

import '../Models/app_mode.dart';
import '../Models/new_patient.dart';
import '../Models/new_pharmacist.dart';

class MyColors {
  static const Color myPurple = Color(0xff4F518C);
  static const Color myOrange = Color(0xffF87060);
  static const Color myGrey = Color(0xFF757575);
  static const Color myPink = Color(0xffFBB7AF);
  static const Color myWhite = Color(0xffFAFAFA);
  static const Color myBlack = Color(0xff0F0A0A);
  static const Color myBlue = Color(0xFF1982FC);
  static const Color myBackGround = Color(0xFFF8F8F8);
  static const Color myBackGround2 = Color(0xFFEEEEEE);
  static const Color myRed = Color(0xFFF44336);
}

NewPatient? mainPatient;
NewPharmacist? mainPharmacist;
AppMode? appMode;
String? firstTime;

String? token;
String? onBoard;
String? userType;
String? expireAt;
