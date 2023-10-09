import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../main.dart';
import '../../../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../../../PATIENT/Patient%20Profile/presentation/views/widgets/patient_activity_item.dart';
import '../../../../Pharmacist%20Profile/presentation/manager/edit_pharmacist_profile_cubit/pharmacist_profile_cubit.dart';
import '../../../../../Resignation/presentation/views/widgets/custom_auth_form_field.dart';
import '../../../../../Resignation/presentation/views/widgets/show_snake_bar.dart';
import '../../../../../../core/utils/components.dart';
import '../../../../../../core/utils/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class EditPharmacistProfileView extends StatefulWidget {
  const EditPharmacistProfileView({Key? key}) : super(key: key);
  @override
  State<EditPharmacistProfileView> createState() =>
      _EditPharmacistProfileState();
}

class _EditPharmacistProfileState extends State<EditPharmacistProfileView> {
  bool flag3 = false;
  bool flag4 = false;
  bool flag5 = false;

  bool isPassword1 = true;
  bool isPassword2 = true;

  final pharmacyNameController = TextEditingController();
  final pharmacistNameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final locController = TextEditingController();

  final riKey1 = GlobalKey<FormState>();
  final riKey2 = GlobalKey<FormState>();
  final riKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<PharmacistProfileCubit, PharmacistProfileState>(
      listener: (context, state) async {
        if (state is EditPasswordSuccess) {
          showSnackBar(
            context,
            'Password has been successfully changed',
            Colors.green,
          );
        } else if (state is EditPharmacistNameSuccess) {
          showSnackBar(
            context,
            'Pharmacist name has been successfully changed',
            Colors.green,
          );

        } else if (state is EditPharmacyNameSuccess) {
          showSnackBar(
            context,
            'Pharmacy Name has been successfully changed',
            Colors.green,
          );

        } else if (state is PharmacistProfileFailure) {
          if (state.errMessage == "incorrect password!") {
            showSnackBar(context, 'Incorrect Password !');
          } else {
            showSnackBar(context, state.errMessage);
          }
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: false,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Column(
                    children: [
                      PatientActivityItem(
                        height: height,
                        width: width,
                        text: "Edit Password",
                        icon: Icons.lock_open,
                        onTap: () {
                          setState(() {
                            flag3 = !flag3;
                            flag4 = false;
                            flag5 = false;
                          });
                        },
                        trailing: Icons.arrow_drop_down,
                      ),
                      Visibility(
                        visible: flag3,
                        child: Form(
                          key: riKey1,
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      CustomAuthFormField(
                                        controller: oldPasswordController,
                                        text: 'old Password',
                                        prefixIcon: Icons.lock,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        isPassword: isPassword1,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This Field is required';
                                          } else if (value.length < 8) {
                                            return "Password mustn't have less than 8 characters";
                                          }
                                          return null;
                                        },
                                        suffixIcon: isPassword1
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        suffixFunction: () {
                                          setState(() {
                                            isPassword1 = !isPassword1;
                                          });
                                        },
                                        isMobile: MyApp.isMobile,
                                        width: width,
                                      ),
                                      const SizedBox(height: 10),
                                      CustomAuthFormField(
                                        controller: newPasswordController,
                                        text: 'new Password',
                                        prefixIcon: Icons.lock,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        isPassword: isPassword2,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This Field is required';
                                          } else if (value.length < 8) {
                                            return "Password musn't have less than 8 characters";
                                          }
                                          return null;
                                        },
                                        suffixIcon: isPassword2
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        suffixFunction: () {
                                          setState(() {
                                            isPassword2 = !isPassword2;
                                          });
                                        },
                                        isMobile: MyApp.isMobile,
                                        width: width,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: CustomElevatedButton(
                                      radius: 6,
                                      onPressed: () async {
                                        if (riKey1.currentState!.validate() &&
                                            kDebugMode) {

                                          await BlocProvider.of<
                                                      PharmacistProfileCubit>(
                                                  context)
                                              .editPharmacistPassword(
                                            bodyRequest: {
                                              "name": mainPharmacist!.name,
                                              "pharmacyName": mainPharmacist!.pharmacyName,
                                              "location": {
                                                "lng": mainPharmacist!.lng,
                                                "lat": mainPharmacist!.lat
                                              },
                                              "newPassword":
                                                  newPasswordController.text,
                                              "password":
                                                  oldPasswordController.text,
                                              "isChattingAvailable": true,
                                              "isDeliveryAvailable": true
                                            },
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 110,
                                    child: CustomElevatedButton(
                                      radius: 6,
                                      backgroundColor: Colors.red,
                                      onPressed: () {
                                        setState(() => flag3 = !flag3);
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      separate(),
                      PatientActivityItem(
                        height: height,
                        width: width,
                        text: "Edit Pharmacist Name",
                        icon: Icons.person,
                        onTap: () {
                          setState(() {
                            flag4 = !flag4;
                            flag3 = false;
                            flag5 = false;
                          });
                        },
                        trailing: Icons.arrow_drop_down,
                      ),
                      Visibility(
                        visible: flag4,
                        child: Form(
                          key: riKey2,
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      CustomAuthFormField(
                                        controller: pharmacistNameController,
                                        text: 'Pharmacist Name',
                                        prefixIcon: Icons.person,
                                        textInputType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This Field is required';
                                          } else if (value.length < 6) {
                                            return "Name mustn't have less than 6 characters";
                                          }
                                          return null;
                                        },
                                        isMobile: MyApp.isMobile,
                                        width: width,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: CustomElevatedButton(
                                      radius: 6,
                                      onPressed: () async {
                                        if (riKey2.currentState!.validate() &&
                                            kDebugMode) {
                                          await BlocProvider.of<
                                                      PharmacistProfileCubit>(
                                                  context)
                                              .editPharmacistName(
                                            bodyRequest: {
                                              "name":
                                                  pharmacistNameController.text,
                                              "pharmacyName":
                                                  mainPharmacist!.pharmacyName,
                                              "location": {
                                                "lng": mainPharmacist!.lng,
                                                "lat": mainPharmacist!.lat
                                              },
                                              "isChattingAvailable": true,
                                              "isDeliveryAvailable": true
                                            },
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 110,
                                    child: CustomElevatedButton(
                                      radius: 6,
                                      backgroundColor: Colors.red,
                                      onPressed: () {
                                        setState(() => flag3 = !flag3);
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      separate(),
                      PatientActivityItem(
                        height: height,
                        width: width,
                        text: "Edit Pharmacy Name",
                        icon: Icons.local_pharmacy_sharp,
                        onTap: () {
                          setState(() {
                            flag5 = !flag5;
                            flag3 = false;
                            flag4 = false;
                          });
                        },
                        trailing: Icons.arrow_drop_down,
                      ),
                      Visibility(
                        visible: flag5,
                        child: Form(
                          key: riKey3,
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      CustomAuthFormField(
                                        controller: pharmacyNameController,
                                        text: 'Pharmacy Name',
                                        prefixIcon: Icons.local_pharmacy_sharp,
                                        textInputType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This Field is required';
                                          } else if (value.length < 6) {
                                            return "Name mustn't have less than 6 characters";
                                          }
                                          return null;
                                        },
                                        isMobile: MyApp.isMobile,
                                        width: width,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: CustomElevatedButton(
                                      radius: 6,
                                      onPressed: () async {
                                        if (riKey3.currentState!.validate() &&
                                            kDebugMode) {

                                          await BlocProvider.of<
                                                      PharmacistProfileCubit>(
                                                  context)
                                              .editPharmacyName(
                                            bodyRequest: {
                                              "name": mainPharmacist!.name,
                                              "pharmacyName":
                                                  pharmacyNameController.text,
                                              "location": {
                                                "lng": mainPharmacist!.lng,
                                                "lat": mainPharmacist!.lat
                                              },
                                              "isChattingAvailable": true,
                                              "isDeliveryAvailable": true
                                            },
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 110,
                                    child: CustomElevatedButton(
                                      radius: 6,
                                      backgroundColor: Colors.red,
                                      onPressed: () {
                                        setState(() => flag3 = !flag3);
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      separate(),
                    ],
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
