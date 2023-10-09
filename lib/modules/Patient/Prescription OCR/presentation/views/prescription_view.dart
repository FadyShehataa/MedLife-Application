import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../main.dart';
import '../../../Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../../../Prescription%20OCR/presentation/manager/prescription_cubit/prescription_cubit.dart';
import '../../../../Resignation/presentation/views/widgets/show_snake_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/utils/constants.dart';
import 'prescription_result_view.dart';

class PrescriptionView extends StatelessWidget {
  PrescriptionView({Key? key}) : super(key: key);

  PickedFile? img;
  bool isLoading = false;

  final ImagePicker piker = ImagePicker();
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
              "Choose Prescription Photo",
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
                        Navigator.pop(context);
                        takePhoto(ImageSource.camera, context);
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
                        Navigator.pop(context);
                        takePhoto(ImageSource.gallery, context);
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

    return BlocConsumer<PrescriptionCubit, PrescriptionState>(
      listener: (context, state) {
        if (state is PrescriptionLoading) {
          isLoading = true;
        } else if (state is PrescriptionSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PrescriptionResultView(),
            ),
          );
          isLoading = false;
        } else if (state is PrescriptionFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Image(
                      image: AssetImage("assets/images/default_imgs/g.gif"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Center(
                      child: Text(
                        "Please take a clear image for your prescription",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => popUp()),
                        );
                      },
                      radius: 8,
                      child: const Text(
                        'Take your Prescription image',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void takePhoto(ImageSource source, context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    BlocProvider.of<PrescriptionCubit>(context)
        .fetchPrescription(pickedFile: image);
  }
}
