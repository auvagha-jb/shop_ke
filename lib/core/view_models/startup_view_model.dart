import 'package:flutter/material.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/home_view.dart';
import 'package:shop_ke/ui/views/welcome_view.dart';


class StartupViewModel extends BaseViewModel {
  final SharedPreferencesService sharedPreferences = locator<SharedPreferencesService>();
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
    //Default view
    Widget widget = WelcomeView();

    //Error check for snapshot
    if (snapshot.hasError) {
      _errorService.showSnapshotError(snapshot, generalExceptionResponse);
      return LoadingView();
    }

    final containsId = snapshot.data as bool;
    //If sharedPreferences contain id key the user had logged in
    if (containsId) {
      widget = HomeView();
    }

    return widget;
  }
}
