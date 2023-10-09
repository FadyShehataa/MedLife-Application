import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../PATIENT/Patient%20Profile/presentation/views/widgets/patient_info.dart';
import '../../../../Pharmacist%20Profile/presentation/views/widgets/pharmacist_activity.dart';

import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_loading_indicator.dart';
import '../../../../../../main.dart';
import '../../../../../../core/utils/constants.dart';
import '../../manager/edit_pharmacist_profile_cubit/pharmacist_profile_cubit.dart';

class PharmacistProfileViewBody extends StatefulWidget {
  const PharmacistProfileViewBody({Key? key}) : super(key: key);

  @override
  State<PharmacistProfileViewBody> createState() =>
      _PharmacistProfileViewBodyState();
}

class _PharmacistProfileViewBodyState extends State<PharmacistProfileViewBody> {
  final ImagePicker piker = ImagePicker();
  PickedFile? img;

  @override
  Widget build(BuildContext context) {
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
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera,
                            color: MyColors.myBlue,
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
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          color: MyColors.myBlue,
                          size: MyApp.isMobile ? 50 : 80,
                        ),
                        Text("Gallery",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: MyApp.isMobile ? 15 : 35,
                                color: Colors.black)),
                      ],
                    ),
                  ),
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
                PharmacistProfileCubit.get(context).imgVisibility();
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

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          children: [
            Stack(
              children: [
                BlocBuilder<PharmacistProfileCubit, PharmacistProfileState>(
                    builder: (context, state) {
                  if (state is PharmacistProfileLoading) {
                    return const CustomLoadingIndicator();
                  } else if (state is PharmacistProfileFailure) {
                    return CustomErrorWidget(errMessage: state.errMessage);
                  } else {
                    return SizedBox(
                      height: MyApp.isMobile ? 160 : 300,
                      width: MyApp.isMobile ? 160 : 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: CachedNetworkImage(
                          imageUrl: mainPharmacist!.pharmacyImage!,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 40,
                          ),
                        ),
                      ),
                    );
                  }
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
                      padding:
                          EdgeInsets.only(right: MyApp.isMobile ? 15.0 : 20),
                      child: Container(
                        width: MyApp.isMobile ? 40 : 70,
                        height: MyApp.isMobile ? 40 : 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: MyColors.myBlue.withOpacity(0.8),
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
            const SizedBox(height: 20),
            UserInfoWidget(
              name: mainPharmacist!.pharmacyName!,
              phoneNumber: mainPharmacist!.email!,
            ),
            const SizedBox(height: 30),
            PharmacistActivity(),
          ],
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    BlocProvider.of<PharmacistProfileCubit>(context)
        .updateImage(pickedImage: image);
  }

  void deletePhoto() async {
    BlocProvider.of<PharmacistProfileCubit>(context).deleteImage();
  }
}
