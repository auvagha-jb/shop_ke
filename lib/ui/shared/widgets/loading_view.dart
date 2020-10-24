import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/icon_type.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';

import 'app_icon.dart';

class LoadingView extends StatelessWidget {
  final Icon icon;
  final bool hasProgressIndicator;
  final String title;
  final String description;

  const LoadingView({
    Key key,
    this.icon,
    this.hasProgressIndicator = true,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppIcon(
              iconType: IconType.Primary,
              icon: icon,
            ),

            //Display feedback if any
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(title ?? '', style: primaryHeader1),
                    title != null ? SizedBox(height: 12.0) : Text(''),
                    Text(description ?? '', style: darkSubHeader),
                  ],
                ),
              ),
            ),

            //Show progressIndicator if the argument is true else return empty text widget
            hasProgressIndicator ? CircularProgressIndicator() : Text(''),
          ],
        ),
      ),
    );
  }
}
