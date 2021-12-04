import 'package:flutter/material.dart';
import 'package:flutter_login/pages/login/login_page.dart';
import 'package:flutter_login/pages/profile/profile_page.dart';

class RouteGenerator {
  /// to generate route that can be tested.
  /// the widget page can easily be tested in widget testing since we inject the argument through class constructor
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // getting arguments passed in while calling Navigator.pushNamed("nameHere", arguments: args)
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case ProfilePage.routeName:
        if (args is ProfilePageArgs) {
          return MaterialPageRoute(builder: (_) => ProfilePage(args: args));
        } else {
          return _errorRouteGeneration("wrong argument data type for EventCancellationExplanationPage");
        }

      default:
        return _errorRouteGeneration(
          "the route name is not recognized. Probably the route name (${routeSettings.name}) has not been registered in RouteGenerator class",
        );
    }
  }

  static Route<dynamic> _errorRouteGeneration(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error"), centerTitle: true),
        body: const Center(child: Text("Error")),
      );
    });
  }
}
