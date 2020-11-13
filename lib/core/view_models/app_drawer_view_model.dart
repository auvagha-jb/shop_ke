import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/drawer_item.dart';
import 'package:shop_ke/core/models/firestore_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/views/profile_view.dart';
import 'package:shop_ke/ui/views/welcome_view.dart';
import 'package:stacked_services/stacked_services.dart';


class AppDrawerViewModel extends BaseViewModel {
  static final _sharedPreferences =locator<SharedPreferencesService>();
  static final _navigationService = locator<NavigationService>();
  static final DialogService _dialogService = locator<DialogService>();

  final drawerItems = [
    DrawerItem(
      icon: Icon(Icons.account_circle),
      title: 'Profile',
      onPressed: () =>
          _navigationService.navigateTo(ProfileStartupView.routeName),
    ),
    DrawerItem(
      icon: Icon(Icons.exit_to_app),
      title: 'Logout',
      onPressed: () => logOut(),
    ),
  ];

  static void logOut() async {
    final logoutConfirmed = await confirmLogout();

    if (!logoutConfirmed) {
      return;
    }
    _sharedPreferences.removeAll();
    _navigationService.replaceWith(WelcomeView.routeName);
  }

  static Future<bool> confirmLogout() async {
    final ServiceResponse serviceResponse =
        await _sharedPreferences.getCustomer();
    final customer = serviceResponse.response as Customer;

    final DialogResponse response = await _dialogService.showConfirmationDialog(
      title: 'Confirmation Logout',
      description: 'Do you want to log out as ${customer.firstName}?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    return response.confirmed;
  }
}
