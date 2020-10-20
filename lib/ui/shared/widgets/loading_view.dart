import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/icon_type.dart';

import 'app_icon.dart';

class LoadingView extends StatelessWidget {
  final Icon icon;
  final bool hasProgressIndicator;

  const LoadingView({
    Key key,
    this.icon,
    this.hasProgressIndicator = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppIcon(
              iconType: IconType.Light,
              icon: icon,
            ),

            //Show progressIndicator if the argument is true else return empty text widget
            hasProgressIndicator ? CircularProgressIndicator() : Text(''),
          ],
        ),
      ),
    );
  }
}
