import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ke/app_router.dart';
import 'package:shop_ke/core/services/app_services/connectivity_service.dart';
import 'package:shop_ke/themes/style.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/models/app_models/cart.dart';
import 'core/models/data_models/product.dart';
import 'locator.dart';

void main() async {
  //Init dependency injector
  setupLocator();

  //Init firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final noWifiView = MaterialApp(
    home: LoadingView(
      hasProgressIndicator: false,
      title: 'Whoops! Lost Connection',
      description: 'Please check your internet connection and try again',
      icon: Icon(Icons.wifi_off),
    ),
    theme: lightTheme(),
  );

  final waitingForConnectionView = MaterialApp(
    home: LoadingView(
      title: 'Checking your internet connection',
      description:
          ' If it takes more than a few seconds, check your network connection',
      icon: Icon(Icons.hourglass_bottom_outlined),
    ),
    theme: lightTheme(),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //Register the providers used
      providers: [
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Product()),
      ],

      //Stream builder to monitor the state of the network connection
      child: StreamBuilder<ConnectivityResult>(
          stream: locator<ConnectivityService>().stream,
          builder: (context, snapshot) {
            print('Connectivity Status: ${snapshot.data}');

            if (snapshot.hasError) {
              print(snapshot.error);
              return noWifiView;
            }

            if (snapshot.data == null) {
              return waitingForConnectionView;
            }

            if (snapshot.data == ConnectivityResult.none) {
              return noWifiView;
            }

            //What to display when the connection is established
            return MaterialApp(
              title: 'Project Pay',
              theme: lightTheme(),
              //Imported from themes/styles
              onGenerateRoute: AppRouter.generateRoute,
              //Imported from ui/app_router.dart
              navigatorKey: locator<NavigationService>().navigatorKey,
            );
          }),
    );
  }
}
