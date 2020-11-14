import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_ke/ui/views/authentication/login_view.dart';
import 'package:shop_ke/ui/views/authentication/reset_password_view.dart';
import 'package:shop_ke/ui/views/authentication/sign_up_view.dart';
import 'package:shop_ke/ui/views/general/home_view.dart';
import 'package:shop_ke/ui/views/general/startup_view.dart';
import 'package:shop_ke/ui/views/general/welcome_view.dart';
import 'package:shop_ke/ui/views/store_owner/register_store_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case StartupView.routeName: //Initial Route
        return MaterialPageRoute(builder: (_) => StartupView());

      case WelcomeView.routeName:
        return MaterialPageRoute(builder: (_) => WelcomeView());

      case LoginView.routeName:
        return MaterialPageRoute(builder: (_) => LoginView());

      case SignUpView.routeName:
        return MaterialPageRoute(builder: (_) => SignUpView());

      case ResetPasswordView.routeName:
        String email = settings.arguments;
        return MaterialPageRoute(builder: (_) => ResetPasswordView(email: email));

      case HomeView.routeName:
        return MaterialPageRoute(builder: (_) => HomeView());

      case RegisterStoreView.routeName:
        return MaterialPageRoute(builder: (_) => RegisterStoreView());
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
