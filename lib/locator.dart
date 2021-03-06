import 'package:get_it/get_it.dart';
import 'package:shop_ke/core/services/app_services/connectivity_service.dart';
import 'package:shop_ke/core/services/app_services/error_service.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/app_services/sockets_service.dart';
import 'package:shop_ke/core/services/firebase_services/email_authentication_service.dart';
import 'package:shop_ke/core/view_models/app_view_models/drawer_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/authentication_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/camera_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/confirm_order_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/home_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/movies_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/my_orders_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/profile_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/search_products_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/shopping_app_bar_view_model.dart';
import 'package:shop_ke/core/view_models/app_view_models/startup_view_model.dart';
import 'package:shop_ke/core/view_models/owner_view_models/add_product_view_model.dart';
import 'package:shop_ke/core/view_models/owner_view_models/inventory_view_model.dart';
import 'package:shop_ke/core/view_models/owner_view_models/owner_home_view_model.dart';
import 'package:shop_ke/core/view_models/owner_view_models/register_store_view_model.dart';

import 'package:stacked_services/stacked_services.dart';


///We will be providing a bunch of **models and services**
///app at global context scale. Instead we'll inject it using the locator setup in locator.dart.

final locator = GetIt.instance;

void setupLocator() {
  //Services
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => EmailAuthenticationService());
  locator.registerLazySingleton(() => ErrorService());
  locator.registerLazySingleton(() => SocketsService());
  locator.registerLazySingleton(() => ConnectivityService());

  //Stacked Services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());

  //ViewModels
  locator.registerFactory(() => ShoppingAppbarViewModel());
  locator.registerFactory(() => DrawerViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => MoviesViewModel());
  locator.registerFactory(() => SearchProductViewModel());
  locator.registerFactory(() => ConfirmOrderViewModel());
  locator.registerFactory(() => MyOrdersViewModel());
  locator.registerFactory(() => AuthenticationViewModel());
  locator.registerFactory(() => ProfileViewModel());
  locator.registerFactory(() => CameraViewModel());
  locator.registerFactory(() => StartupViewModel());

  //Owner ViewModels
  locator.registerFactory(() => OwnerHomeViewModel());
  locator.registerFactory(() => RegisterStoreViewModel());
  locator.registerFactory(() => InventoryViewModel());
  locator.registerFactory(() => AddProductViewModel());
}
