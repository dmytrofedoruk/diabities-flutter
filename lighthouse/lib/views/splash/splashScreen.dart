import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lighthouse/helpers/AppConstants.dart';
import 'package:lighthouse/views/auth/login/loginScreen.dart';
import 'package:lighthouse/views/dashboard/dashboard_tabs.dart';
import 'package:lighthouse/views/home/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        boxColor = const Color.fromRGBO(211, 243, 107, 1);
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        boxColor = Colors.white;
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(const Duration(milliseconds: 3200), () {
      secondAnim = true;

      scaleController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      )..forward();
      scaleAnimation = Tween<double>(begin: 0.0, end: 12).animate(scaleController);

      setState(() {
        boxColor = Colors.white;
        _d = true;
      });
    });
    Timer(const Duration(milliseconds: 4200), () {
      secondAnim = true;
      setState(() {});
      var token = sharedPreferences.getString(AppConstants.userNameKey);

      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DashBoardTabs()), (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginScreen()), (Route<dynamic> route) => false);
      }
    });

    // afterBuildCreated(() async {
    //   setValue(appOpenCount, (getIntAsync(appOpenCount)) + 1);
    //   await appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage), context: context);
    // });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? _h / 2.5
                      : 20,
              width: 20,
            ),
            AnimatedContainer(
              duration: Duration(seconds: _c ? 2 : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                      ? 130
                      : 20,
              width: _d
                  ? _w
                  : _c
                      ? 130
                      : 20,
              decoration: BoxDecoration(
                  color: boxColor,
                  //shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: _d ? const BorderRadius.only() : BorderRadius.circular(30)),
              child: secondAnim
                  ? Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(color: Color.fromRGBO(233, 235, 240, 0.584), shape: BoxShape.circle),
                        //  color: themeMode.obs.value == ThemeMode.dark ? Get.theme.cardColor : Get.theme.splashColor, shape: BoxShape.circle),
                        child: AnimatedBuilder(
                          animation: scaleAnimation,
                          builder: (c, child) => Transform.scale(
                            scale: scaleAnimation.value,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: _e
                          ? Image.asset('assets/logo.png', color: Colors.blue[900], height: 130, width: 130, fit: BoxFit.contain)
                          : const SizedBox(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
