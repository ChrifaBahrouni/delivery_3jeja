import 'package:delivery_3jeja/models/product.dart';
import 'package:delivery_3jeja/screens/Partenaire/screens/partenaire_screen.dart';
import 'package:delivery_3jeja/screens/coursie/main_coursie.dart';
import 'package:delivery_3jeja/screens/profile/edit_profile.dart';
import 'package:delivery_3jeja/screens/login_page.dart';
import 'package:delivery_3jeja/screens/main_page.dart';
import 'package:delivery_3jeja/screens/order_accepted_page.dart';
import 'package:delivery_3jeja/screens/preload_page.dart';
import 'package:delivery_3jeja/screens/product_details_page.dart';
import 'package:delivery_3jeja/screens/register_page.dart';
import 'package:delivery_3jeja/screens/search_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Login_page.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Login_page(),
      );

    case EditProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditProfilePage(),
      );
    case RegisterPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterPage(),
      );
    case MainScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainScreen(),
      );
    case SearchPage.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchPage(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailsPage.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsPage(
          product: product,
        ),
      );
    case PartenaireScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PartenaireScreen(),
      );

    case OrderAcceptedPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderAcceptedPage(),
      );
    case MainCoursie.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainCoursie(),
      );
    case PreloadPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PreloadPage(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
