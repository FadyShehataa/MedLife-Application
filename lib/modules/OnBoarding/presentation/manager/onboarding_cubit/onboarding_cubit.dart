import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit(initialState) : super(OnBoardingInitialState());

  late bool isLast = false;
  late String button = 'Next';

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  void isLastState() {
    isLast = true;
    button = 'Get Started';
    emit(IsLastState());
  }

  void notLastState() {
    isLast = false;
    button = 'Next';
    emit(IsLastState());
  }
}
