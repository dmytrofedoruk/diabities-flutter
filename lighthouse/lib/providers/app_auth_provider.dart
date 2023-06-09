// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:lighthouse/services/app_auth_service.dart';

import 'package:lighthouse/views/auth/login/deivce_selection_screen.dart';
import 'package:lighthouse/views/auth/subscription/subscritption_webview.dart';
import 'package:lighthouse/views/dashboard/dashboard_tabs.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';

class AppAuthProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  AppAuthProvider(this.sharedPreferences);
  bool isLoading = false;
  bool rememebme = false;

  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  isValid({required String email, required String password, required BuildContext context}) {
    if (email.trim().isEmpty) {
      Utils.errorSnackBar(context, "Email is Required ");
    } else if (password.trim().isEmpty) {
      Utils.errorSnackBar(context, "Password is Required ");
    } else {
      loginInApp(context: context, email: email.trim(), password: password.trim());
    }
  }

  isValidForSignup({required String name, required String email, required String password, required String subType, required BuildContext context}) {
    if (name.trim().isEmpty) {
      Utils.errorSnackBar(context, "Name is Required ");
    } else if (email.trim().isEmpty) {
      Utils.errorSnackBar(context, "Email is Required ");
    } else if (password.trim().isEmpty) {
      Utils.errorSnackBar(context, "Password is Required ");
    } else {
      signUpApp(context: context, email: email, password: password, name: name, subType: subType);
    }
  }

  Future<void> loginInApp({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    showOrHideLoader(true);

    var result = await AppAuthService.loginInAppLighHouse(email: email, password: password);

    if (result != null) {
      sharedPreferences.setString(AppConstants.ApplicationtokenKey, result["token"]);
      sharedPreferences.setString(AppConstants.applicationuserIdKey, result["userId"].toString());
      sharedPreferences.setString(AppConstants.nightScoutUrl, result["userDetails"]["nightscout_url"].toString());

      log(result.toString());
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DashBoardTabs()));
      // checkAppSubScription(context: context, email: email, password: password, token: result["token"]);
    } else {
      // log("error" + result.toString());
      Utils.errorSnackBar(context, "Invalid email or password");
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> signUpApp({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String subType,
  }) async {
    showOrHideLoader(true);

    var result = await AppAuthService.signUpApi(email: email, password: password, name: name);

    if (result != null) {
      sharedPreferences.setString(AppConstants.ApplicationtokenKey, result["token"]);

      if (subType == "monthly") {
        log(subType);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SubscriptionWebview(
                  SubScriptionUrl: "https://buy.stripe.com/test_fZeaFPcQyapg3hm8ww",
                )));
      } else {
        log(subType);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SubscriptionWebview(
                  SubScriptionUrl: "https://buy.stripe.com/test_6oEaFPdUC6903hmeUV",
                )));
      }

      log(result.toString());
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DeviceSelectionScreen()));
      // checkAppSubScription(context: context, email: email, password: password, token: result["token"]);
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> checkAppSubScription({
    required BuildContext context,
    required String email,
    required String password,
    required String token,
  }) async {
    showOrHideLoader(true);
    var token = sharedPreferences.getString(
      AppConstants.ApplicationtokenKey,
    );

    var result = await AppAuthService.checkAppSubScription(email: email, password: password, token: token ?? "");

    if (result != null) {
      log(result.toString());
      // libreLoginModel = LibreLoginModel.fromMap(result);
      // if (libreLoginModel != null) {
      //   if (libreLoginModel?.data?.authTicket?.token != null) {
      //     libreConnection(context: context, token: libreLoginModel!.data!.authTicket!.token!);
      //   } else {
      //     Utils.errorSnackBar(context, "No User Found");
      //     showOrHideLoader(false);
      //   }
      // }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }
}
