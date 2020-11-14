import 'package:shop_ke/core/services/firestore_services/customers_collection.dart';
import 'package:shop_ke/core/services/sockets_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  bool cartOccupiesFullScreen = false;
  bool cameraIsReady = false;
  final DialogService _dialogService = locator<DialogService>();
  final SocketsService _socketsService = locator<SocketsService>();
  final CustomersCollection customersCollection =
      locator<CustomersCollection>();

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
      _dialogService.showDialog(
        title: cameraNotReadyResponse.title,
        description: cameraNotReadyResponse.message,
      );

      return;
    }

    cameraIsReady = isReady;

    //If camera is ready show the live camera feed, rebuild the widget tree
    notifyListeners();

    print('cameraIsReady: $isReady');
  }
}
