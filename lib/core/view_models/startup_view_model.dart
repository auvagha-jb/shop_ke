import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/authentication/login_view.dart';
import 'package:shop_ke/ui/views/general/home_view.dart';
import 'package:shop_ke/ui/views/general/welcome_view.dart';
import 'package:shop_ke/ui/views/store_owner/owner_home_view.dart';

class StartupViewModel extends BaseViewModel {
  final SharedPreferencesService sharedPreferences =
      locator<SharedPreferencesService>();
  final ErrorService _errorService = locator<ErrorService>();

  Widget startupFutureBuilder(AsyncSnapshot snapshot) {
    //Default view
    Widget widget = LoadingView();

    //What shows while the future is not ready
    if (snapshot.connectionState == ConnectionState.done) {
      widget = getWidget(snapshot);
    }

    return widget;
  }

  Widget getWidget(AsyncSnapshot<dynamic> snapshot) {
    //Error check for snapshot
    if (snapshot.hasError) {
      _errorService.showSnapshotError(snapshot, generalExceptionResponse);
      return LoadingView();
    }

    final ServiceResponse serviceResponse = snapshot.data;

    if (!serviceResponse.status) {
      return LoginView();
    }

    final Customer customer = serviceResponse.response;
    //If customer is null then they had not logged in
    if (customer == null) {
      return WelcomeView();
    }

    Widget widget;

    if (customer.isShopOwner) {
      widget = OwnerHomeView();
    } else {
      widget = HomeView();
    }

    return widget;
  }
}
