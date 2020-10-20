import 'package:get_it/get_it.dart';
import 'package:shop_ke/core/services/api_service.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/firebase_services/email_authentication_service.dart';
import 'package:shop_ke/core/services/firebase_services/firestore_service.dart';
import 'package:shop_ke/core/services/firebase_services/phone_authentication_service.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/sockets_service.dart';
import 'package:shop_ke/core/view_models/app_drawer_view_model.dart';
import 'package:shop_ke/core/view_models/authentication_view_model.dart';
import 'package:shop_ke/core/view_models/camera_view_model.dart';
import 'package:shop_ke/core/view_models/home_view_model.dart';
import 'package:shop_ke/core/view_models/profile_view_model.dart';
import 'package:shop_ke/core/view_models/startup_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

///We will be providing a bunch of **models and services**
///app at global context scale. Instead we'll inject it using the locator setup in locator.dart.

final locator = GetIt.instance;

void setupLocator() {
  //Services
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => PhoneAuthenticationService());
  locator.registerLazySingleton(() => EmailAuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => ErrorService());
  locator.registerLazySingleton(() => SocketsService());

  //Stacked Services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

  //ViewModels
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => AuthenticationViewModel());
  locator.registerFactory(() => ProfileViewModel());
  locator.registerFactory(() => CameraViewModel());
  locator.registerFactory(() => AppDrawerViewModel());
  locator.registerFactory(() => StartupViewModel());
}