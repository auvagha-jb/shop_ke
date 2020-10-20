import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/profile_view_model.dart';

import 'base_view.dart';

class ProfileStartupView extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileStartupViewState createState() => _ProfileStartupViewState();
}

class _ProfileStartupViewState extends State<ProfileStartupView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      builder: (context, model, child) => FutureBuilder(
        future: model.sharedPreferences.getCustomer(),
        builder: (context, snapshot) {
          return model.profileViewFutureBuilder(snapshot);
        },
      ),
    );
  }
}
