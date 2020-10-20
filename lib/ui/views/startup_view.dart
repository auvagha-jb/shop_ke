import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/startup_view_model.dart';

import 'base_view.dart';

class StartupView extends StatefulWidget {
  static const routeName = "/";

  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartupViewModel>(
      builder: (context, model, child) => FutureBuilder(
        future: model.sharedPreferences.containsId(),
        //This has to be fetched beforehand in the initState or an equivalent method
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return model.startupFutureBuilder(snapshot);
        },
      ),
    );
  }
}
