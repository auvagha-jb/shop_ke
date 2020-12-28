import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/app_view_models/camera_view_model.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CameraViewModel>(
      builder: (context, model, child) => Container(),
    );
  }
}
