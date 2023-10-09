import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../main.dart';
import 'login_patient_view.dart';
import 'verification_code_patient.dart';
import 'widgets/show_snake_bar.dart';
//import 'package:medlife_app/shared/classes/Controllers/Notification/NotificationController.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:medlife_app/modules/PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import 'package:medlife_app/modules/Resignation/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:medlife_app/modules/Resignation/presentation/views/widgets/custom_auth_form_field.dart';
import 'package:medlife_app/modules/Resignation/presentation/views/widgets/custom_auth_text_button.dart';
import '../../../../core/utils/constants.dart';

class SignUpPatientView extends StatelessWidget {
  SignUpPatientView({Key? key}) : super(key: key);

  final numberController = TextEditingController();
  final nameController = TextEditingController();

  //final CustomNotification notification = CustomNotification();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String phoneNumber = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpPatientLoading) {
          isLoading = true;
        } else if (state is SignUpPatientSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerificationCodePatient(
                verificationToken: state.data['verificationToken'].toString(),
              ),
            ),
          );
          isLoading = false;
        } else if (state is SignUpPatientFailure) {
          if (state.errMessage ==
              "there's already a patient with the entered phone number!") {
            showSnackBar(context, 'Patient has already been registered !');
          } else if (state.errMessage == "invalid phone number!") {
            showSnackBar(context, 'Invalid phone number !');
          } else if (state.errMessage == "Name should not contain numbers !") {
            showSnackBar(context, 'Invalid phone number !');
          } else {
            showSnackBar(context, state.errMessage);
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              automaticallyImplyLeading: true,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize:
                                MyApp.isMobile ? width * 0.06 : width * 0.04,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: MyApp.isMobile
                                    ? width * 0.04
                                    : width * 0.0253,
                              ),
                            ),
                            CustomAuthTextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LoginPatientView();
                                    },
                                  ),
                                );
                              },
                              text: 'Sign-In',
                              isMobile: MyApp.isMobile,
                              width: width,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomAuthFormField(
                          controller: nameController,
                          text: 'Full Name',
                          prefixIcon: Icons.person,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            } else if (value.contains(RegExp(r'[0-9]'))) {
                              return 'Name should not contain numbers';
                            } else if (value.length < 6) {
                              return "Name musn't have less than 6 characters";
                            }
                            return null;
                          },
                          isMobile: MyApp.isMobile,
                          width: width,
                        ),
                        const SizedBox(height: 30),
                        IntlPhoneField(
                          controller: numberController,
                          decoration: InputDecoration(
                              counter: const Offstage(),
                              labelText: 'Phone Number',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: width * 0.02)),
                          style: TextStyle(
                              fontSize: MyApp.isMobile ? null : width * 0.03),
                          initialCountryCode: 'EG',
                          showDropdownIcon: true,
                          onChanged: (phone) {
                            phoneNumber = phone.completeNumber;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'This Field is required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 30.0),
                        CustomAuthFormField(
                          controller: passwordController,
                          text: 'Password',
                          prefixIcon: Icons.lock,
                          textInputType: TextInputType.visiblePassword,
                          isPassword:
                              BlocProvider.of<AuthCubit>(context).isPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            } else if (value.length < 8) {
                              return "Password musn't have less than 8 characters";
                            }
                            return null;
                          },
                          suffixIcon:
                              BlocProvider.of<AuthCubit>(context).isPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                          suffixFunction: () {
                            BlocProvider.of<AuthCubit>(context)
                                .passwordVisibility();
                          },
                          isMobile: MyApp.isMobile,
                          width: width,
                        ),
                        const SizedBox(height: 40),
                        CustomElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                kDebugMode) {
                              BlocProvider.of<AuthCubit>(context).signUpPatient(
                                bodyRequest: {
                                  "name": nameController.text,
                                  "phoneNumber": phoneNumber,
                                  "password": passwordController.text
                                },
                              );
                            }
                          },
                          radius: 8,
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        privacyPolicyAndTermsOfService(MyApp.isMobile, width),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget privacyPolicyAndTermsOfService(isMobile, width) => Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text.rich(TextSpan(
            text: 'By clicking on the button ,you agree to our',
            style: TextStyle(
              fontSize: isMobile ? width * 0.040 : width * 0.03,
            ),
            children: [
              TextSpan(
                  text: ' Terms of Service',
                  style: TextStyle(
                      fontSize: isMobile ? width * 0.045 : width * 0.035,
                      color: MyColors.myBlue, //Colors.blue,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              TextSpan(
                  text: ' and',
                  style: TextStyle(
                    fontSize: isMobile ? width * 0.040 : width * 0.03,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(
                            fontSize: isMobile ? width * 0.045 : width * 0.035,
                            color: MyColors.myBlue, //Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {})
                  ])
            ])),
      ),
    );
