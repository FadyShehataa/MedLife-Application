import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../main.dart';
import '../../../../Patient%20Profile/presentation/views/widgets/patient_activity.dart';
import '../../../../Patient%20Profile/presentation/views/widgets/patient_info.dart';

import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../../../core/utils/constants.dart';
import '../../manager/edit_patient_profile_cubit/patient_profile_cubit.dart';

class PatientProfileViewBody extends StatefulWidget {
  const PatientProfileViewBody({Key? key}) : super(key: key);

  @override
  State<PatientProfileViewBody> createState() => _PatientProfileViewBodyState();
}

class _PatientProfileViewBodyState extends State<PatientProfileViewBody> {
  bool img = false;


  final ImagePicker piker = ImagePicker();
  var name;

  @override
  void initState() {
    super.initState();
    name = mainPatient!.name;
  }

  @override
  Widget build(BuildContext context) {
    if (mainPatient!.imageURL != '') {
      PatientProfileCubit.get(context).img = true;
    }

    Widget popUp() {
      return Container(
        height: MyApp.isMobile ? 150.0 : 220,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Text(
              "Choose Profile Photo",
              style: TextStyle(
                fontSize: MyApp.isMobile ? 20.0 : 40,
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
                        takePhoto(ImageSource.camera);
                        //close the pop up
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera,
                            color: MyColors.myBlue,
                            //color: Colors.blue,
                            size: MyApp.isMobile ? 50 : 80,
                          ),
                          Text("Camera",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: MyApp.isMobile ? 15 : 35,
                                  color: Colors.black)),
                        ],
                      )),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        takePhoto(ImageSource.gallery);
                        //close the pop up
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: MyColors.myBlue,
                            //color: Colors.blue,
                            size: MyApp.isMobile ? 50 : 80,
                          ),
                          Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: MyApp.isMobile ? 15 : 35,
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

    Widget firstPopUp(context) {
      return Container(
        height: MyApp.isMobile ? 80.0 : 220,
        //width: MediaQuery.of(context).size.width-200,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                    context: context, builder: ((builder) => popUp()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.file_upload_outlined,
                    color: MyColors.myBlue,
                    //color: Colors.blue,
                    //size:MyApp.isMobile? 35:80,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add or Update Image",
                    style: TextStyle(
                      fontSize: MyApp.isMobile ? 22.0 : 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                PatientProfileCubit.get(context).imgVisibility();
                setState(() {
                  deletePhoto();
                  Navigator.pop(context);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                    //size:MyApp.isMobile? 35:80,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Remove Image",
                    style: TextStyle(
                        fontSize: MyApp.isMobile ? 22.0 : 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    BlocBuilder<PatientProfileCubit, PatientProfileState>(
                        builder: (context, state) {
                      if (state is PatientProfileLoading) {
                        return CustomLoadingIndicator();
                      } else if (state is PatientProfileFailure) {
                        return CustomErrorWidget(errMessage: state.errMessage);
                      }
                      return SizedBox(
                        height: MyApp.isMobile ? 160 : 300,
                        width: MyApp.isMobile ? 160 : 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: CachedNetworkImage(
                            imageUrl: mainPatient!.imageURL!,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              size: 40,
                            ),
                            // placeholder: (context, url) => const CustomLoadingIndicator(),
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => firstPopUp(context)),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: MyApp.isMobile ? 15.0 : 20),
                          child: Container(
                            width: MyApp.isMobile ? 40 : 70,
                            height: MyApp.isMobile ? 40 : 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyColors.myBlue.withOpacity(0.8), //Colors.blue.withOpacity(0.8),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black87,
                              size: MyApp.isMobile ? 30 : 55,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                UserInfoWidget(
                  name: name,
                  phoneNumber: mainPatient!.phoneNumber!,
                ),
                const SizedBox(height: 30),
                PatientActivity(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    BlocProvider.of<PatientProfileCubit>(context)
        .updateImage(pickedImage: image);
  }

  void deletePhoto() async {
    BlocProvider.of<PatientProfileCubit>(context).deleteImage();
  }
}

Future<void> deletePatientData() async {

  mainPatient!.name = '';
  mainPatient!.phoneNumber = '';
  mainPatient!.imageURL = '';
  mainPatient!.token = '';
  mainPatient!.id = '';

  appMode!.userType = '';
  await appMode?.save();

}
