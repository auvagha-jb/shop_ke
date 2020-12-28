import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_ke/core/services/app_services/error_service.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';

class CameraViewModel extends BaseViewModel {
  List<CameraDescription> cameras; //Initialized in main.dart
  CameraDescription firstCamera;
  final ErrorService _errorService = locator<ErrorService>();

  Future<CameraController> initCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;

    return CameraController(
      firstCamera, //The specific camera to use
      ResolutionPreset.medium, //The resolution to use
    );
  }

  Widget cameraFutureBuilder({
    @required AsyncSnapshot<dynamic> snapshot,
    @required CameraController cameraController,
  }) {
    //Default widget
    Widget widget = LoadingView(
      icon: Icon(Icons.camera),
      hasProgressIndicator: false,
    );

    //Once the future is resolved, get the Widget to show
    if (snapshot.connectionState == ConnectionState.done) {
      widget = getWidget(snapshot, cameraController);
    }

    return widget;
  }

  Widget getWidget(AsyncSnapshot snapshot, CameraController cameraController) {
    //The live camera preview
    Widget widget;
    //The widget that
    Widget errorWidget = LoadingView(
      icon: Icon(Icons.error),
      hasProgressIndicator: false,
    );

    //Error check
    if (snapshot.hasError) {
      _errorService.showSnapshotError(snapshot, cameraExceptionResponse);
      return errorWidget;
    }

    widget = CameraPreview(cameraController);

    return widget;
  }

  void takePicture({
    @required Future<void> initializeControllerFuture,
    @required CameraController controller,
  }) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await initializeControllerFuture;

      // Construct the path where the image should be saved using the path
      // package.
      final path = join(
        // Store the picture in the temp directory.
        // Find the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      // Attempt to take a picture and log where it's been saved.
      await controller.takePicture(path);

      print('Picture taken.');
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }
}
