import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';

class StoreNameText extends StatelessWidget {
  final SharedPreferencesService sharedPreferences =
      locator<SharedPreferencesService>();
  final TextStyle style;

  StoreNameText({Key key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
//      initialData: ServiceResponse(status: true, response: 'My Dashboard'),
      future: sharedPreferences.getStoreName(),
      builder: (BuildContext context, AsyncSnapshot<ServiceResponse> snapshot) {
        var defaultWidget = CircularProgressIndicator();
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            ServiceResponse serviceResponse = snapshot.data;
            return Text(
              serviceResponse.response,
              style: style,
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text(
              'Shop KE',
              style: primaryHeader2,
            );
          } else {
            return defaultWidget;
          }
        } else {
          return defaultWidget;
        }
      },
    );
  }
}
