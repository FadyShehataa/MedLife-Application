import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../main.dart';
import '../../../../Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../../Patient%20Profile/presentation/manager/edit_patient_profile_cubit/patient_profile_cubit.dart';
import '../../../../Patient%20Profile/presentation/views/widgets/patient_activity_item.dart';
import '../../../../../Resignation/presentation/views/widgets/custom_auth_form_field.dart';
import '../../../../../Resignation/presentation/views/widgets/show_snake_bar.dart';
import '../../../../../../core/utils/components.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../core/utils/constants.dart';

class EditPatientProfileView extends StatefulWidget {
  const EditPatientProfileView({Key? key}) : super(key: key);
  static var name='';

  static getName(){
    return name;
  }

  @override
  State<EditPatientProfileView> createState() => _EditPharmacistProfileState();
}

class _EditPharmacistProfileState extends State<EditPatientProfileView> {
  bool flag1 = false;
  bool flag2 = false;
  bool flag3 = false;
  bool flag4 = false;

  bool isPassword1 = true;
  bool isPassword2 = true;

  final nameController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  final riKey1 = GlobalKey<FormState>();
  final riKey2 = GlobalKey<FormState>();
  final riKey3 = GlobalKey<FormState>();

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<PatientProfileCubit, PatientProfileState>(
      listener: (context, state) {
        if (state is PatientProfileLoading) {
          isLoading = true;
        } else if (state is PatientProfileSuccess) {
          showSnackBar(
            context,
            'Details Updated Successfully',
            Colors.green,
          );
          isLoading = false;
        } else if (state is PatientProfileFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                                  PatientProfileCubit>(context)
                                              .editPatientPassword(
                                            bodyRequest: {
                                              "name": mainPatient!.name,
                                              "newPassword":
                                                  newPasswordController.text,
                                              "password":
                                                  oldPasswordController.text
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
                        text: "Edit Name",
                        icon: Icons.person,
                        onTap: () {
                          setState(() {
                            flag4 = !flag4;
                            flag3 = false;

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
                                        controller: nameController,
                                        text: 'Name',
                                        prefixIcon: Icons.person,
                                        textInputType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This Field is required';
                                          } else if (value.length < 8) {
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
                                                  PatientProfileCubit>(context)
                                              .editPatientName(
                                            bodyRequest: {
                                              "name": nameController.text
                                            },
                                          );
                                          EditPatientProfileView.name=nameController.text;
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
                                        setState(() => flag4 = !flag4);
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
