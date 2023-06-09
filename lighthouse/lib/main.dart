import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lighthouse/providers/EmergencyCallProvider.dart';
import 'package:lighthouse/providers/app_auth_provider.dart';
import 'package:lighthouse/providers/dexcom_provider.dart';
import 'package:lighthouse/providers/hue_auth_provider.dart';
import 'package:lighthouse/providers/dashboard_provider.dart';
import 'package:lighthouse/providers/device_details_provider.dart';
import 'package:lighthouse/providers/hueHomeProvider.dart';
import 'package:lighthouse/providers/libre_auth_provider.dart';
import 'package:lighthouse/providers/libre_home_provider.dart';
import 'package:lighthouse/views/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Routes.dart';

late SharedPreferences sharedPreferences;

Future initializePrefs() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = getCustomThemeData(context, brightness: Brightness.light);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => HueProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => HueAuthProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => HueDeviceDetailsProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => DashBoardProvider()),
        ChangeNotifierProvider(create: (_) => LibreAuthProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => LibreHomeProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => EmergencyCallProvider(sharedPreferences)),
        ChangeNotifierProvider(create: (_) => DexcomProvider(sharedPreferences)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: "/",
        navigatorKey: navigatorKey,
        title: "Lighthouse",
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      ),
    );
  }
}
