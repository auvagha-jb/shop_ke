import 'package:flutter/material.dart';
import 'package:shop_ke/app_router.dart';
import 'package:shop_ke/themes/style.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Pay',
      theme: lightTheme(), //Imported from themes/styles
      onGenerateRoute: AppRouter.generateRoute, //Imported from ui/app_router.dart
    );
  }
}
