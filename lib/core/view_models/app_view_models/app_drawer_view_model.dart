import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/app_models/drawer_item.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/views/authentication/login_view.dart';
import 'package:shop_ke/ui/views/general/home_view.dart';
import 'package:shop_ke/ui/views/general/profile_view.dart';
import 'package:shop_ke/ui/views/general/welcome_view.dart';
import 'package:shop_ke/ui/views/store_owner/inventory_view.dart';
import 'package:shop_ke/ui/views/store_owner/owner_home_view.dart';
import 'package:stacked_services/stacked_services.dart';

class DrawerViewModel extends BaseViewModel {
  final sharedPreferences = locator<SharedPreferencesService>();
  static final _sharedPreferences = locator<SharedPreferencesService>();
  static final _navigationService = locator<NavigationService>();
  static final _dialogService = locator<DialogService>();

  static final _appDrawerItems = [
    DrawerItem(
      icon: Icon(Icons.account_circle_outlined),
      title: 'My Profile',
      onPressed: () =>
          _navigationService.navigateTo(ProfileStartupView.routeName),
    ),
    DrawerItem(
      icon: Icon(Icons.exit_to_app),
      title: 'Logout',
      onPressed: () => logOut(),
    ),
  ];

  final _storeDashboardLink = DrawerItem(
    icon: Icon(Icons.store_mall_directory_outlined),
    title: 'Store Dashboard',
    onPressed: () => _navigationService.navigateTo(OwnerHomeView.routeName),
  );

  final _ownerDrawerItems = [
    DrawerItem(
      icon: Icon(Icons.home_outlined),
      title: 'Home',
      onPressed: () => _navigationService.navigateTo(OwnerHomeView.routeName),
    ),
    DrawerItem(
      icon: Icon(Icons.inventory),
      title: 'My Inventory',
      onPressed: () => _navigationService.navigateTo(InventoryView.routeName),
    ),
    DrawerItem(
      icon: Icon(Icons.shopping_cart_outlined),
      title: 'Shop',
      onPressed: () => _navigationService.navigateTo(HomeView.routeName),
    ),
  ];

  List<DrawerItem> get ownerDrawerItems {
    _ownerDrawerItems.addAll(_appDrawerItems);
    return _ownerDrawerItems;
  }

  Future<List<DrawerItem>> get appDrawerItems async {
    ServiceResponse serviceResponse = await _sharedPreferences.getCustomer();
    if (!serviceResponse.status) {
      _navigationService.navigateTo(LoginView.routeName);
      return null;
    }

    List<DrawerItem> appDrawerItems = [..._appDrawerItems];

    Customer customer = serviceResponse.response;
    if (customer.isShopOwner) {
      appDrawerItems.add(_storeDashboardLink);
    }

    return appDrawerItems;
  }

  ListView getDrawerListView(List<DrawerItem> drawerItems) {
    return ListView.separated(
      //To make sure it takes up as much space as it needs rather than expanding to fill parent
      shrinkWrap: true,
      itemCount: drawerItems.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(drawerItems[index].title),
        leading: drawerItems[index].icon,
        onTap: drawerItems[index].onPressed,
      ),
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

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
