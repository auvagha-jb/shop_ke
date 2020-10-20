import 'package:connectivity/connectivity.dart';

class CheckConnection {
  final String alertTitle = "No internet connection";
  final String alertBody =
      "This action requires internet connection. Please connect to wifi or mobile data and try again";
  final String alertButton = "Continue";

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool connected = true;

    //Others are ConnectivityResult.mobile, ConnectivityResult.wifi
    if (connectivityResult == ConnectivityResult.none) {
      // Mobile is not Connected to Internet
      connected = false;
    }
    print("Connection status: $connected");
    return connected;
  }

}
