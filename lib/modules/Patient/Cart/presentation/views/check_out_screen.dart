import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../manager/cart_cubit/cart_cubit.dart';
import '../manager/order_cart_cubit/order_cart_cubit.dart';
import 'widgets/custom_elevated_button.dart';
import '../../../patient_main_view.dart';
import '../../../../Resignation/presentation/views/widgets/custom_auth_form_field.dart';
import '../../../../Resignation/presentation/views/widgets/show_snake_bar.dart';
import '../../../../../core/utils/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../main.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  final formKey = GlobalKey<FormState>();

  final locController = TextEditingController();

  double? latitude;

  double? longitude;

  bool isShown = false;

  bool requiredLoc = false;

  bool req = false;

  FocusNode addressNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isLoading = false;

    Future<void> _showAlertDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button to dismiss dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Order Confirmation'),
            content: const Text('Your order has been successfully placed!'),
            actions: <Widget>[
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => PatientMainView()),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }

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
        CartCubit.get(context).updatePosition(position);
      }).catchError((e) {
        debugPrint(e);
      });
    }

    return BlocConsumer<OrderCartCubit, OrderCartState>(
      listener: (context, state) {
        if (state is OrderCartLoading) {
          isLoading = true;
        } else if (state is OrderCartSuccess) {
          _showAlertDialog(context);
          isLoading = false;
        } else if (state is OrderCartFailure) {
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
                'Checkout',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 30, left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAuthFormField(
                              textInputType: TextInputType.text,
                              text: 'Enter your Address manually',
                              prefixIcon: Icons.edit_location_alt,
                              controller: locController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is required';
                                }
                                return null;
                              },
                              isMobile: MyApp.isMobile,
                              width: width),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () async {
                              await getCurrentPosition(context);
                              latitude = CartCubit.get(context)
                                  .currentPosition
                                  ?.latitude;
                              longitude = CartCubit.get(context)
                                  .currentPosition
                                  ?.longitude;
                              setState(() {
                                isShown = true;
                              });
                              requiredLoc = true;
                            },
                            child: DottedBorder(
                              strokeWidth: 2,
                              //color: Colors.blue,
                              color: MyColors.myBlue,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      size: MyApp.isMobile ? 50 : width * 0.09,
                                      //color: Colors.blue,
                                      color: MyColors.myBlue,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: isShown
                                          ? Visibility(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Latitude: ${latitude?.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      //color: Colors.blue,
                                                      color: MyColors.myBlue,
                                                      fontSize: MyApp.isMobile
                                                          ? null
                                                          : width * 0.025,
                                                    ),
                                                  ),
                                                  Text(
                                                    'longitude: ${longitude?.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      //color: Colors.blue,
                                                      color: MyColors.myBlue,
                                                      fontSize: MyApp.isMobile
                                                          ? null
                                                          : width * 0.025,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Visibility(
                                              child: Text(
                                                'Get Current Location',
                                                style: TextStyle(
                                                  //color: Colors.blue,
                                                  color: MyColors.myBlue,
                                                  fontSize: MyApp.isMobile
                                                      ? 16
                                                      : width * 0.025,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Text(
                                'Total Price: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: MyApp.isMobile ? 25 : 40,
                                ),
                              ),
                              Text(
                                '${BlocProvider.of<CartCubit>(context).totalPrice} EGP',
                                style: TextStyle(
                                  fontSize: MyApp.isMobile ? 25 : 40,
                                  color: MyColors.myBlue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          CustomElevatedButton(
                            radius: 12,
                            onPressed: () {
                              req = true;
                              if (formKey.currentState!.validate() &&
                                  kDebugMode &&
                                  requiredLoc) {
                                List<String> orderIDs = [];
                                for (var element
                                    in BlocProvider.of<CartCubit>(context)
                                        .cart) {
                                  orderIDs.add(element.id!);
                                }
                                BlocProvider.of<OrderCartCubit>(context)
                                    .orderCart(bodyRequest: {
                                  "items": orderIDs,
                                  "location": {
                                    "lng": longitude,
                                    "lat": latitude
                                  },
                                  "address": locController.text
                                });
                              }
                              if (req && (!requiredLoc)) {
                                showSnackBar(context,
                                    "please enter all required information");
                              }
                            },
                            child: Text(
                              'Confirm Order',
                              style:
                                  TextStyle(fontSize: MyApp.isMobile ? 20 : 30),
                            ),
                          ),
                        ],
                      ),
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
