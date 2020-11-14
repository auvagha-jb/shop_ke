import 'package:get_it/get_it.dart';
import 'package:shop_ke/core/services/api_service.dart';
import 'package:shop_ke/core/services/connectivity_service.dart';
import 'package:shop_ke/core/services/email_authentication_service.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/firestore_services/customers_collection.dart';
import 'package:shop_ke/core/services/firestore_services/stores_collection.dart';
import 'package:shop_ke/core/services/firestore_services/subscriptions_collection.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/sockets_service.dart';
import 'package:shop_ke/core/view_models/app_drawer_view_model.dart';
import 'package:shop_ke/core/view_models/authentication_view_model.dart';
import 'package:shop_ke/core/view_models/camera_view_model.dart';
import 'package:shop_ke/core/view_models/home_view_model.dart';
import 'package:shop_ke/core/view_models/profile_view_model.dart';
import 'package:shop_ke/core/view_models/startup_view_model.dart';
import 'package:shop_ke/core/view_models/store_owner_view_model.dart';
import 'package:stacked_services/stacked_services.dart';


///We will be providing a bunch of **models and services**
///app at global context scale. Instead we'll inject it using the locator setup in locator.dart.

final locator = GetIt.instance;

void setupLocator() {
  //Services
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => EmailAuthenticationService());
  locator.registerLazySingleton(() => ErrorService());
  locator.registerLazySingleton(() => SocketsService());
  locator.registerLazySingleton(() => ConnectivityService());

  //Stacked Services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

  //Firestore Services
  locator.registerLazySingleton(() => CustomersCollection());
  locator.registerLazySingleton(() => StoresCollection());
  locator.registerLazySingleton(() => SubscriptionsCollection());

  //ViewModels
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => AuthenticationViewModel());
  locator.registerFactory(() => ProfileViewModel());
  locator.registerFactory(() => CameraViewModel());
  locator.registerFactory(() => DrawerViewModel());
  locator.registerFactory(() => StartupViewModel());
  locator.registerFactory(() => OwnerViewModel());
}