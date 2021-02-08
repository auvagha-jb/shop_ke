import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/ui/views/authentication/login_view.dart';
import 'package:shop_ke/ui/views/authentication/reset_password_view.dart';
import 'package:shop_ke/ui/views/authentication/sign_up_view.dart';
import 'package:shop_ke/ui/views/general/confirm_order_view.dart';
import 'package:shop_ke/ui/views/general/home_view.dart';
import 'package:shop_ke/ui/views/general/movies_view.dart';
import 'package:shop_ke/ui/views/general/my_orders_view.dart';
import 'package:shop_ke/ui/views/general/recommended_movies_view.dart';
import 'package:shop_ke/ui/views/general/search_products_view.dart';
import 'package:shop_ke/ui/views/general/startup_view.dart';
import 'package:shop_ke/ui/views/general/welcome_view.dart';
import 'package:shop_ke/ui/views/product_details/product_details_view.dart';
import 'package:shop_ke/ui/views/store_owner/add_product_view.dart';
import 'package:shop_ke/ui/views/store_owner/inventory_view.dart';
import 'package:shop_ke/ui/views/store_owner/owner_home_view.dart';
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

      case ProductDetailsView.routeName:
        final Product product = settings.arguments;
        return MaterialPageRoute(builder: (_) => ProductDetailsView(product));

      case SearchProductsView.routeName:
        final List<Product> products = settings.arguments;
        return MaterialPageRoute(builder: (_) => SearchProductsView(products));

      case ConfirmOrderView.routeName:
        return MaterialPageRoute(builder: (_) => ConfirmOrderView());

      case MyOrdersView.routeName:
        return MaterialPageRoute(builder: (_) => MyOrdersView());

      case MoviesView.routeName:
        return MaterialPageRoute(builder: (_) => MoviesView());

      case RecommendedMoviesView.routeName:
        String movieTitle = settings.arguments;
        return MaterialPageRoute(builder: (_) => RecommendedMoviesView(movieTitle: movieTitle));

      //Owner Routes
      case OwnerHomeView.routeName:
        return MaterialPageRoute(builder: (_) => OwnerHomeView());

      case RegisterStoreView.routeName:
        return MaterialPageRoute(builder: (_) => RegisterStoreView());

      case InventoryView.routeName:
        return MaterialPageRoute(builder: (_) => InventoryView());

      case AddProductView.routeName:
        return MaterialPageRoute(builder: (_) => AddProductView());

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
