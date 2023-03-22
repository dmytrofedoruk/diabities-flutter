import 'package:flutter/material.dart';
import 'package:lighthouse/views/home/homeScreen.dart';
import 'package:lighthouse/views/splash/splashScreen.dart';

class Routes {
  Routes._();

  static routes() => <String, WidgetBuilder>{
        // SecondDisplay.routeName: (context) => const SecondDisplay(),
      };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AppSplashScreen(), settings: settings);
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: settings);

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
    }
  }
}
