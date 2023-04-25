import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/helpers/AppConstants.dart';
import 'package:lighthouse/views/auth/login/loginScreen.dart';
import 'package:lighthouse/views/dashboard/dashboard_tabs.dart';
import 'package:lighthouse/views/hue_home/hue_homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/joining_screens/joinning_screen.dart';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/ProkitSplashScreen';

  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  bool _a = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;
  bool secondAnim = false;

  Color boxColor = Colors.transparent;
  late SharedPreferences sharedPreferences;

  Future initializePrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializePrefs();
    init();
  }

  void init() async {
    Timer(const Duration(milliseconds: 2200), () {
      setState(() {});
      var token = sharedPreferences.getString(AppConstants.ApplicationtokenKey);

      if (token != null) {
        if (token.trim().isNotEmpty) {
          log(token);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DashBoardTabs()), (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const JoiningScreen()), (Route<dynamic> route) => false);
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const JoiningScreen()), (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            Center(
              child: Image.asset('assets/logo_white.png', height: 200, width: 190, fit: BoxFit.contain),
            ),
            // const Spacer(),
            Positioned(
              bottom: 30,
              left: MediaQuery.of(context).size.width * 0.45,
              child: const CupertinoActivityIndicator(
                radius: 15,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ));
  }
}
