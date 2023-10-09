import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../main.dart';
import '../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../manager/auth_cubit/auth_cubit.dart';
import 'login_pharmacist_view.dart';
import 'sign_up_patient_view.dart';
import 'verification_code_pharmacist.dart';
import 'widgets/custom_auth_form_field.dart';
import 'widgets/custom_auth_text_button.dart';
import 'widgets/show_snake_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/utils/constants.dart';

class SignUpPharmacistView extends StatelessWidget {
  SignUpPharmacistView({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final pharmacyNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //final CustomNotification notification = CustomNotification();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final ImagePicker piker = ImagePicker();

  var temporaryImage;
  bool isShown = false;
  bool showImage = false;
  bool requiredImg = false;
  bool requiredLoc = false;
  bool req = false;
  var latitude;
  var longitude;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    Future<bool> _handleLocationPermission(context) async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }

    Future<void> getCurrentPosition(context) async {
      final hasPermission = await _handleLocationPermission(context);

      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        AuthCubit.get(context).updatePosition(position);
      }).catchError((e) {
        debugPrint(e);
      });
    }

    Future takePhoto(ImageSource source, context) async {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      temporaryImage = File(image!.path);
      AuthCubit.get(context).uploadImage(temporaryImage);
    }

    Widget popUp(context) {
      return Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            const Text(
              "Choose Profile Photo",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        takePhoto(ImageSource.camera, context);
                      },
                      child:  const Column(
                        children: [
                          Icon(
                            Icons.camera,
                            color: Colors.deepPurple,
                            size: 50,
                          ),
                          Text("Camera",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.black)),
                        ],
                      )),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        takePhoto(ImageSource.gallery, context);
                      },
                      child:  const Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.deepPurple,
                            size: 50,
                          ),
                          Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.black)),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      );
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpPatientLoading) {
          isLoading = true;
        } else if (state is SignUpPatientSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerificationCodePharmacist(
                verificationToken: state.data['verificationToken'].toString(),
              ),
            ),
          );
          isLoading = false;
        } else if (state is SignUpPatientFailure) {
          if (state.errMessage ==
              "there's already a pharmacist with the entered email!") {
            showSnackBar(context, 'Pharmacy has already been registered !');
          } else if (state.errMessage == "invalid email!") {
            showSnackBar(context, 'Invalid email !');
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
                                      return LoginPharmacistView();
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
                              return "Name should be at least 6 characters!";
                            }
                            return null;
                          },
                          isMobile: MyApp.isMobile,
                          width: width,
                        ),
                        const SizedBox(height: 30),
                        CustomAuthFormField(
                          controller: pharmacyNameController,
                          text: 'Pharmacy Name',
                          prefixIcon: Icons.local_pharmacy_sharp,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            } else if (value.contains(RegExp(r'[0-9]'))) {
                              return 'Name should not contain numbers';
                            } else if (value.length < 6) {
                              return "Pharmacy name should be at least 6 characters!";
                            }
                            return null;
                          },
                          isMobile: MyApp.isMobile,
                          width: width,
                        ),
                        const SizedBox(height: 30),
                        CustomAuthFormField(
                          controller: emailController,
                          text: 'Email Address',
                          prefixIcon: Icons.email,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            } else if (value.isNotEmpty &&
                                !value.contains('@')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          isMobile: MyApp.isMobile,
                          width: width,
                        ),
                        const SizedBox(height: 30),
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
                              return "Password mustn't have less than 8 characters";
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
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => popUp(context)));
                                  showImage = true;
                                  requiredImg = true;
                                },
                                child: DottedBorder(
                                  strokeWidth: 2,
                                  color: MyColors.myBlue, //Colors.blue,
                                  radius: const Radius.circular(30),
                                  child: Container(
                                    height: MyApp.isMobile
                                        ? height * 0.155
                                        : height * 0.12,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: (showImage &&
                                            AuthCubit.get(context).img != null)
                                        ? Visibility(
                                            child: Image.file(
                                              File(AuthCubit.get(context).img!.path),
                                              height: MyApp.isMobile
                                                  ? height * 0.155
                                                  : height * 0.12,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Visibility(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: MyApp.isMobile
                                                      ? 50
                                                      : width * 0.09,
                                                  color: MyColors.myBlue, //Colors.blue,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 7),
                                                  child: Text(
                                                    "Upload Pharmacy's license Image",
                                                    style: TextStyle(
                                                        color: MyColors.myBlue, //Colors.blue,
                                                        fontSize: MyApp.isMobile
                                                            ? 15
                                                            : width * 0.025),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await getCurrentPosition(context);
                                  //print("lll");
                                  latitude = AuthCubit.get(context)
                                      .currentPosition
                                      ?.latitude;
                                  longitude = AuthCubit.get(context)
                                      .currentPosition
                                      ?.longitude;
                                  isShown = true;
                                  requiredLoc = true;
                                },
                                child: DottedBorder(
                                  strokeWidth: 2,
                                  color: MyColors.myBlue,//Colors.blue,
                                  radius: const Radius.circular(30),
                                  child: Container(
                                    height: MyApp.isMobile
                                        ? height * 0.155
                                        : height * 0.12,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          size: MyApp.isMobile
                                              ? 50
                                              : width * 0.09,
                                          color: MyColors.myBlue,//Colors.blue,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 30),
                                          child: isShown
                                              ? Visibility(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          'LATITUDE: $latitude',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepPurple,
                                                              fontSize: MyApp
                                                                      .isMobile
                                                                  ? null
                                                                  : width *
                                                                      0.025)),
                                                      Text(
                                                          ',LONGITUDE: $longitude',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepPurple,
                                                              fontSize: MyApp
                                                                      .isMobile
                                                                  ? null
                                                                  : width *
                                                                      0.025)),
                                                    ],
                                                  ),
                                                )
                                              : Visibility(
                                                  child: Text(
                                                    'GET CURRENT LOCATION',
                                                    style: TextStyle(
                                                        color: MyColors.myBlue,//Colors.blue,
                                                        fontSize: MyApp.isMobile
                                                            ? null
                                                            : width * 0.025),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomElevatedButton(
                          onPressed: () {
                            req = true;
                            if (formKey.currentState!.validate() &&
                                kDebugMode &&
                                requiredImg &&
                                requiredLoc) {
                              BlocProvider.of<AuthCubit>(context)
                                  .signUpPharmacist(
                                      email: emailController.text,
                                      name: nameController.text,
                                      password: passwordController.text,
                                      pharmacyName: pharmacyNameController.text,
                                      pickedFile: image,
                                      lat: latitude,
                                      lng: longitude,
                              );
                            }
                            if (req && (!requiredLoc || !requiredImg)) {
                              showSnackBar(context,
                                  "please enter all required information");
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
