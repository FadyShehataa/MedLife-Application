import 'dart:async';

import 'package:device_preview/device_preview.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medlife_app/modules/PATIENT/Cart/data/repos/cart_repo_impl.dart';
import 'package:medlife_app/modules/PATIENT/Chat/presentation/manager/chat_details_cubit/chat_details_cubit.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Home/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Profile/data/repos/patient_profile_repo_impl.dart';
import 'package:medlife_app/modules/PATIENT/Patient%20Profile/presentation/manager/edit_patient_profile_cubit/patient_profile_cubit.dart';
import 'package:medlife_app/modules/PATIENT/Prescription%20OCR/data/repos/prescription_ocr_repo_impl.dart';
import 'package:medlife_app/modules/PATIENT/Prescription%20OCR/presentation/manager/prescription_cubit/prescription_cubit.dart';
import 'package:medlife_app/modules/PATIENT/Reminder/data/repos/reminder_repo_impl.dart';
import 'package:medlife_app/modules/PATIENT/Reminder/presentation/manager/reminder_cubit/reminder_cubit.dart';
import 'package:medlife_app/modules/PATIENT/Search/data/repos/search_repo_impl.dart';
import 'package:medlife_app/modules/PATIENT/Search/presentation/manager/filter_search_cubit/filter_search_cubit.dart';
import 'package:medlife_app/modules/PATIENT/Search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Home/data/repos/pharmacist_products_repo_impl.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Home/presentation/manager/add_product_cubit/add_product_cubit.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Home/presentation/manager/pharmacist_product_cubit/pharmacist_product_cubit.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Orders/presentation/manager/pharmacist_order_cubit/pharmacist_orders_cubit.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Predict/data/repos/pharmacist_predict_repo_impl.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Predict/presentation/manager/cubit/pharmacist_predict_cubit.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Profile/data/repos/pharmacist_profile_repo_impl.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist%20Profile/presentation/manager/edit_pharmacist_profile_cubit/pharmacist_profile_cubit.dart';
import 'package:medlife_app/modules/PHARMACIST/Pharmacist Orders/data/repos/pharmacist_order_repo_impl.dart';

import 'package:medlife_app/modules/Splash/presentation/views/splash_view.dart';
import 'package:medlife_app/core/utils/Controllers/Chat/SocketConnection.dart';

import 'package:medlife_app/core/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'core/Models/app_mode.dart';
import 'core/Models/new_patient.dart';
import 'core/Models/new_pharmacist.dart';
import 'core/utils/service_locator.dart';

import 'modules/PATIENT/Cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'modules/PATIENT/Cart/presentation/manager/order_cart_cubit/order_cart_cubit.dart';
import 'modules/PATIENT/Chat/data/repos/chat_repo_impl.dart';
import 'modules/PATIENT/Chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'modules/PATIENT/Favorite/data/repos/favorite_repo_impl.dart';
import 'modules/PATIENT/Favorite/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'modules/PATIENT/Patient Home/data/repos/patient_home_repo_impl.dart';
import 'modules/PATIENT/Patient Home/presentation/manager/categories_cubit/categories_cubit.dart';
import 'modules/PATIENT/Patient Home/presentation/manager/pharmacies_cubit/best_pharmacies_cubit.dart';
import 'modules/PATIENT/Patient Home/presentation/manager/pharmacies_cubit/pharmacies_cubit.dart';
import 'modules/PATIENT/Patient Home/presentation/manager/pharmacy_products_cubit/pharmacy_products_cubit.dart';
import 'modules/Resignation/data/repos/auth_repo_impl.dart';
import 'modules/Resignation/presentation/manager/auth_cubit/auth_cubit.dart';
import 'core/utils/local_network.dart';

Future<void> initSocket() async {
  SocketConnection socketConnection = SocketConnection.getObj();
  await socketConnection.initSocket();
}

late Box box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheNetwork.cacheInitialization();
  firstTime = await CacheNetwork.getCacheData(key: 'FirstTime');

  await Hive.initFlutter();

  if (firstTime == null || firstTime == '') {
    Hive.registerAdapter<NewPharmacist>(NewPharmacistAdapter());
    Hive.registerAdapter<AppMode>(AppModeAdapter());
    Hive.registerAdapter<NewPatient>(NewPatientAdapter());

    box = await Hive.openBox('app');

    box.put("mode", AppMode(userType: 'first time'));
    box.put("patient", NewPatient(name: 'Temp User'));
    box.put("pharmacist", NewPharmacist());

    await CacheNetwork.insertToCache(key: 'FirstTime', value: 'true');
  } else {
    Hive.registerAdapter<NewPharmacist>(NewPharmacistAdapter());
    Hive.registerAdapter<AppMode>(AppModeAdapter());
    Hive.registerAdapter<NewPatient>(NewPatientAdapter());
    box = await Hive.openBox('app');

    appMode = await box.get('mode');

    if (appMode?.userType == 'patient') {
      mainPatient = await box.get('patient');
    } else if (appMode?.userType == 'pharmacist') {
      mainPharmacist = await box.get('pharmacist');
    }
  }

  // await Firebase.initializeApp();
  // CustomNotification customNotification = CustomNotification();
  // await customNotification.requestPermission();

  // await initSocket();

  onBoard = await CacheNetwork.getCacheData(key: 'onBoard');

  setupServiceLocator();
  runApp(
    // const MyApp()
    DevicePreview(
      // enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static bool isMobile = true;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            //Patient
            BlocProvider(
              create: (context) => FavoriteCubit(
                getIt.get<FavoriteRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => CartCubit(
                getIt.get<CartRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => OrderCartCubit(
                getIt.get<CartRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => PharmaciesCubit(
                getIt.get<PatientHomeRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => BestPharmaciesCubit(
                getIt.get<PatientHomeRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => CategoriesCubit(
                getIt.get<PatientHomeRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => PharmacyProductsCubit(
                getIt.get<PatientHomeRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => RatingCubit(
                getIt.get<PatientHomeRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => PatientProfileCubit(
                getIt.get<PatientProfileRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => ReminderCubit(
                getIt.get<ReminderRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => PrescriptionCubit(
                getIt.get<PrescriptionOCRRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => SearchCubit(
                getIt.get<SearchRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => FilterSearchCubit(),
            ),

            //Common
            BlocProvider(
              create: (context) => ChatsCubit(getIt.get<ChatsRepoImpl>()),
            ),
            BlocProvider(
              create: (context) =>
                  ChatDetailsCubit(getIt.get<ChatsRepoImpl>())..getMessages(),
            ),

            // Beginning
            BlocProvider(
              create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
            ),

            // Pharmacist
            BlocProvider(
              create: (context) => PharmacistProductCubit(
                getIt.get<PharmacistProductsRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => AddProductCubit(
                getIt.get<PharmacistProductsRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => PharmacistProfileCubit(
                getIt.get<PharmacistProfileRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => PharmacistOrdersCubit(
                getIt.get<PharmacistOrderRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => PharmacistPredictCubit(
                getIt.get<PharmacistPredictRepoImpl>(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFF8F8F8),
            ),
            home: SplashView(),
          ),
        );
      },
    );
  }
}
