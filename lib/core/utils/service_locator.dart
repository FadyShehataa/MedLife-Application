import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../modules/PATIENT/Cart/data/repos/cart_repo_impl.dart';
import '../../modules/PATIENT/Chat/data/repos/chat_repo_impl.dart';
import '../../modules/PATIENT/Favorite/data/repos/favorite_repo_impl.dart';
import '../../modules/PATIENT/Patient%20Home/data/repos/patient_home_repo_impl.dart';
import '../../modules/PATIENT/Patient%20Profile/data/repos/patient_profile_repo_impl.dart';
import '../../modules/PATIENT/Prescription%20OCR/data/repos/prescription_ocr_repo_impl.dart';
import '../../modules/PATIENT/Reminder/data/repos/reminder_repo_impl.dart';
import '../../modules/PATIENT/Search/data/repos/search_repo_impl.dart';
import '../../modules/PHARMACIST/Pharmacist%20Home/data/repos/pharmacist_products_repo_impl.dart';
import '../../modules/PHARMACIST/Pharmacist%20Predict/data/repos/pharmacist_predict_repo_impl.dart';
import '../../modules/PHARMACIST/Pharmacist%20Profile/data/repos/pharmacist_profile_repo_impl.dart';
import '../../modules/PHARMACIST/Pharmacist Orders/data/repos/pharmacist_order_repo_impl.dart';
import '../../modules/Resignation/data/repos/auth_repo_impl.dart';

import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<FavoriteRepoImpl>(
      FavoriteRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<CartRepoImpl>(CartRepoImpl(getIt.get<ApiService>()));
  getIt
      .registerSingleton<ChatsRepoImpl>(ChatsRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PatientHomeRepoImpl>(
      PatientHomeRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PharmacistProductsRepoImpl>(
      PharmacistProductsRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<ReminderRepoImpl>(
      ReminderRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PharmacistProfileRepoImpl>(
      PharmacistProfileRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PatientProfileRepoImpl>(
      PatientProfileRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PharmacistOrderRepoImpl>(
      PharmacistOrderRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PharmacistPredictRepoImpl>(
      PharmacistPredictRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<PrescriptionOCRRepoImpl>(
      PrescriptionOCRRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<SearchRepoImpl>(
      SearchRepoImpl(getIt.get<ApiService>()));
}
