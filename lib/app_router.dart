import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_ke/ui/views/authentication/login_view.dart';
import 'package:shop_ke/ui/views/authentication/sign_up_view.dart';
import 'package:shop_ke/ui/views/welcome_view.dart';

const String initialRoute = "login";

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeView.routeName:
        return MaterialPageRoute(builder: (_) => WelcomeView());
      case LoginView.routeName:
        return MaterialPageRoute(builder: (_) => LoginView());
      case SignUpView.routeName:
        return MaterialPageRoute(builder: (_) => SignUpView());
      // case 'post':
      //   var post = settings.arguments as Post;
      //   return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
