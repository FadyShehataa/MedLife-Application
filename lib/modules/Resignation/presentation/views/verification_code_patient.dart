
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../PATIENT/Cart/presentation/views/widgets/custom_elevated_button.dart';
import '../manager/auth_cubit/auth_cubit.dart';
import 'auth_main_view.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'widgets/show_snake_bar.dart';

class VerificationCodePatient extends StatelessWidget {
  VerificationCodePatient({Key? key, required this.verificationToken})
      : super(key: key);
  String verificationToken;

  //array of numbers
  List<String> numbers = ['', '', '', ''];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is VerificationLoading) {
          isLoading = true;
        } else if (state is VerificationSuccess) {
          showSnackBar(context, "Verified Successfully!", Colors.green);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AuthMainView(),
            ),
          );
          isLoading = false;
        } else if (state is VerificationFailure) {
          if (state.errMessage == "incorrect verification code!") {
            showSnackBar(context, 'Incorrect verification code !');
          } else if (state.errMessage ==
              "all attempts are incorrect, you will receive a new code!") {
            showSnackBar(context,
                'All attempts are incorrect, you will receive a new code !');
          } else {
            showSnackBar(context, state.errMessage);
          }
          isLoading = false;
        } else if (state is VerificationFailureAllAttempts) {
          showSnackBar(context, state.data['message']);
          verificationToken = state.data['extraData']['verificationToken'];
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: const BackButton(color: Colors.black87),
            ),
            body: Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      const Text(
                        'Verification Code',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(
                        'We have sent a verification code to your phone',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      SizedBox(
                        height: 100,
                        child: Expanded(
                          child: GridView.count(
                            crossAxisCount: 4,
                            crossAxisSpacing: 2,
                            children: List.generate(4,
                                (index) => buildPlaceOfDigit(context, index)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomElevatedButton(
                        onPressed: () async {
                          //concact numbers into string
                          String secretNumber =
                              numbers[0] + numbers[1] + numbers[2] + numbers[3];

                          BlocProvider.of<AuthCubit>(context)
                              .verificationCodePatient(
                            bodyRequest: {
                              "verificationToken": verificationToken,
                              "secretNumber": secretNumber
                            },
                          );
                        },
                        radius: 8,
                        child: const Text(
                          'Confirm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
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

  Widget buildPlaceOfDigit(context, int index) => SizedBox(
        height: 68,
        width: 64,
        child: TextFormField(
          onSaved: (value) {},
          onChanged: (value) {
            numbers[index] = value;
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: Theme.of(context).textTheme.titleLarge,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 3.0,
                    color: Color(0xFFBDBDBD),
                  ))),
        ),
      );
}
