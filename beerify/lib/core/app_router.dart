import 'package:beerify/core/route_constants.dart';
import 'package:beerify/screens/login_screen.dart';
import 'package:beerify/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:beerify/screens/bottom_navigation_bar_screens/navigation_bar_main_screen.dart';

//import 'package:beerify/screens/bottom_navigation_bar_screens/gallery_screen.dart';
//import 'package:beerify/screens/bottom_navigation_bar_screens/home_screen.dart';
//import 'package:beerify/screens/bottom_navigation_bar_screens/profile_screen.dart';

/// A class with a single static method that builds a given screen based on the route path constant given.
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutePaths.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case RoutePaths.navigationRoute:
        return MaterialPageRoute(builder: (_) => NavigationBar());
      //case RoutePaths.galleryRoute:
          //return MaterialPageRoute(builder: (_) => GalleryScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
