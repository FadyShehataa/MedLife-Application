import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../main.dart';
import '../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../PATIENT/patient_main_view.dart';
import '../manager/auth_cubit/auth_cubit.dart';
import 'sign_up_patient_view.dart';
import 'widgets/custom_auth_form_field.dart';
import 'widgets/custom_auth_text_button.dart';
import 'widgets/show_snake_bar.dart';
//import 'package:medlife_app/shared/classes/Controllers/Notification/NotificationController.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPatientView extends StatelessWidget {
  LoginPatientView({Key? key}) : super(key: key);

  final numberController = TextEditingController();

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
        if (state is AuthLoading) {
          isLoading = true;
        } else if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PatientMainView(),
            ),
          );
          isLoading = false;
        } else if (state is AuthFailure) {
          if (state.errMessage ==
              "there's no pharmacist with the entered email!") {
            showSnackBar(context, 'Wrong email !');
          } else if (state.errMessage == "incorrect password!") {
            showSnackBar(context, 'Incorrect Password !');
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
                        const SizedBox(height: 40),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize:
                                MyApp.isMobile ? width * 0.06 : width * 0.04,
                            fontWeight: FontWeight.w700,
                          ),
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
                              BlocProvider.of<AuthCubit>(context).loginPatient(
                                bodyRequest: {
                                  "phoneNumber": phoneNumber,
                                  "password": passwordController.text
                                },
                              );
                            }
                          },
                          radius: 8,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: MyApp.isMobile
                                    ? width * 0.04
                                    : width * 0.03,
                              ),
                            ),
                            CustomAuthTextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPatientView(),
                                  ),
                                );
                              },
                              text: 'Register Now',
                              isMobile: MyApp.isMobile,
                              width: width + width * 0.2,
                            ),
                          ],
                        ),
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
