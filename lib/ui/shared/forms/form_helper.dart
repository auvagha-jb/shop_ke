import 'package:flutter/material.dart';

class FormHelper {
  //Form dimensions
  static const formFieldSpacing = 20.0;
  static const sidePadding = 15.0;
  static const verticalPadding = 25.0;
  
  static InputDecoration buildInputDecoration({
    @required TextEditingController controller,
    @required String labelText,
  }) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(),
      suffixIcon: IconButton(
        onPressed: () {
          controller.clear();
        },
        icon: Icon(Icons.clear),
      ),
    );
  }
}