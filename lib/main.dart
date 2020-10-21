import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/app_router.dart';
import 'package:shop_ke/themes/style.dart';
import 'package:stacked_services/stacked_services.dart';
import 'locator.dart';

void main() async{
  //Init dependency injector
  setupLocator();

  //Init firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
