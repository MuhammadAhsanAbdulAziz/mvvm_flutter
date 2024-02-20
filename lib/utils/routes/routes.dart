import 'package:flutter/material.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/view/home_screen.dart';
import 'package:mvvm_flutter/view/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {


    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (ctx) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (ctx) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (ctx) => const Scaffold(
            body: Center(
              child: Text("No routes defined"),
            ),
          ),
        );
    }
  }
}
