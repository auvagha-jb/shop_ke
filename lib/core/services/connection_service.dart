import 'package:connectivity/connectivity.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class ConnectionService {

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool connected = true;

    //Others are ConnectivityResult.mobile, ConnectivityResult.wifi
    if (connectivityResult == ConnectivityResult.none) {
      // Mobile is not Connected to Internet
      connected = false;
      connectionFailureAlert();
    }

    print("Connection status: $connected");
    return connected;
  }

  void connectionFailureAlert() {
    final _dialogService = locator<DialogService>();
    _dialogService.showDialog(
      title: 'Connection failure',
      description: 'Please check yor internet connection and try again'
    );
  }

}
