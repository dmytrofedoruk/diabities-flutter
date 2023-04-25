import 'package:flutter/material.dart';
import 'package:lighthouse/views/hue_home/hue_homeScreen.dart';
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
      case HueScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HueScreen(), settings: settings);

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
    }
  }
}
