import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/manager/onboarding_cubit/onboarding_cubit.dart';
import 'presentation/views/widgets/boarding_item.dart';
import '../Resignation/presentation/views/auth_main_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../main.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/local_network.dart';
import 'presentation/manager/onboarding_cubit/onboarding_states.dart';
import 'data/models/boarding_model.dart';

class OnBoardingScreenView extends StatefulWidget {
  const OnBoardingScreenView({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenViewState createState() => _OnBoardingScreenViewState();
}

class _OnBoardingScreenViewState extends State<OnBoardingScreenView> {
  var boardController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding/onboarding_1.jpg',
        title: 'Upload Prescription',
        body:
            "Just upload your prescription and we'll help you find it,simple and fast"),
    BoardingModel(
        image: 'assets/images/onboarding/onboarding_2.jpg',
        title: 'Scan Medicine',
        body:
            "Just take the medicine to a place with clear lighting and scan it"),
    BoardingModel(
        image: 'assets/images/onboarding/onboarding_3.jpg',
        title: 'Chat with a pharmacist',
        body:
            'You can chat with any pharmacist at any time and ask him about what you want'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return OnBoardingCubit(OnBoardingInitialState);
      },
      child: BlocBuilder<OnBoardingCubit, OnBoardingStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              actions: [
                TextButton(
                  onPressed: () async {
                    await CacheNetwork.insertToCache(
                        key: 'onBoard', value: 'false');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AuthMainView(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25.0,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: boardController,
                        onPageChanged: (int index) {
                          if (index == boarding.length - 1) {
                            OnBoardingCubit.get(context).isLastState();
                          } else {
                            OnBoardingCubit.get(context).notLastState();
                          }
                        },
                        itemBuilder: (context, index) {
                          return BoardingItem(model: boarding[index]);
                        },
                        itemCount: boarding.length,
                      ),
                    ),
                    Column(
                      children: [
                        SmoothPageIndicator(
                            controller: boardController,
                            count: boarding.length,
                            effect: ExpandingDotsEffect(
                              dotColor: Colors.grey,
                              activeDotColor: MyColors.myBlue, //Colors.blue,
                              dotHeight: MyApp.isMobile ? 10.0 : 15,
                              expansionFactor: 4.0,
                              dotWidth: MyApp.isMobile ? 10.0 : 15,
                              spacing: 5.0,
                            )),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: MyApp.isMobile ? 40.0 : 50,
                          decoration: BoxDecoration(
                            //color: Colors.blue,
                            color: MyColors.myBlue,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: MaterialButton(
                              onPressed: () async {
                                //Last time in onboarding

                                if (OnBoardingCubit.get(context).isLast) {
                                  await CacheNetwork.insertToCache(
                                      key: 'onBoard', value: 'false');
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthMainView(),
                                    ),
                                  );
                                } else {
                                  boardController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 750,
                                      ),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                }
                              },
                              child: Text(
                                OnBoardingCubit.get(context).button,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              )),
                        ),
                        const SizedBox(height: 90.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
