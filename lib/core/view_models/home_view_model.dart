import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/sockets_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';

import '../../locator.dart';

class HomeViewModel extends BaseViewModel {
  bool cartOccupiesFullScreen = false;
  bool cameraIsReady = false;
  final ErrorService _errorService = locator<ErrorService>();
  final SocketsService _socketsService = locator<SocketsService>();

  SocketsService get socketsService => _socketsService;

  void retractCart() {
    cartOccupiesFullScreen = false;
    notifyListeners();
  }

  void extendCart() {
    cartOccupiesFullScreen = true;
    notifyListeners();
  }

  void showCameraPreview(bool isReady) {
    //If the camera is not read to be used, wait...
    if (!isReady) {
      print('Initializing camera. Please wait...');
      _errorService.showUIResponseError(cameraNotReadyResponse);
      return;
    }

    cameraIsReady = isReady;

    //If camera is ready show the live camera feed, rebuild the widget tree
    notifyListeners();

    print('cameraIsReady: $isReady');
  }

  Future<String> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    return barcodeScanRes;
  }
}
