// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:lighthouse/models/libre_login_model.dart';
import 'package:lighthouse/services/libre_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../models/libre_connection_model.dart';
import 'libre_home_provider.dart';

class LibreAuthProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  LibreAuthProvider(this.sharedPreferences);
  bool isLoading = false;
  LibreLoginModel? libreLoginModel;
  LibreConnectionModel? libreConnectionModel;

  String libreToken = "";

  // changeOtpSentStatus(bool isSent) {
  //   isOTPsent = isSent;
  //   notifyListeners();
  // }

  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  Future<void> loginWithLibre({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    showOrHideLoader(true);
    libreLoginModel = null;

    var result = await LibreAuthService.libreLoginService(email: email, password: password);

    if (result != null) {
      libreLoginModel = LibreLoginModel.fromMap(result);
      if (libreLoginModel != null) {
        if (libreLoginModel?.data?.authTicket?.token != null) {
          libreConnection(context: context, token: libreLoginModel!.data!.authTicket!.token!);
        } else {
          Utils.errorSnackBar(context, "No User Found");
          showOrHideLoader(false);
        }
      }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      showOrHideLoader(false);
    }

    notifyListeners();
  }

  Future<void> libreConnection({
    required BuildContext context,
    required String token,
  }) async {
    showOrHideLoader(true);
    notifyListeners();

    var result = await LibreAuthService.libreconnection(token: token);

    if (result != null) {
      if (result["message"] == "invalid or expired jwt") {
        Utils.errorSnackBar(context, "invalid or expired jwt");
      } else if (result.containsKey("data")) {
        libreConnectionModel = LibreConnectionModel.fromMap(result);

        if (libreConnectionModel != null && libreConnectionModel?.data != null && libreConnectionModel!.data!.isNotEmpty) {
          log("saving user data");
          await sharedPreferences.setString(AppConstants.librePatientId, libreConnectionModel?.data!.first.patientId ?? "");
          await sharedPreferences.setString(AppConstants.libreTokenKey, libreConnectionModel?.ticket!.token ?? "");
        }
        Navigator.pop(context);
        Provider.of<LibreHomeProvider>(context, listen: false).libreGetDataFromServer(context: context);

        notifyListeners();
        Utils.successSnackBar(context, "Patient Found");
      }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  // LibreUserModel? libreUserModel;

  // Future<void> libreVerifyLibre({
  //   required BuildContext context,
  //   required String otp,
  // }) async {
  //   showOrHideLoader(true);
  //   libreLoginModel = null;

  //   var result = await LibreAuthService.libreVerifyOTPService(token: libreToken, code: otp);

  //   if (result != null) {
  //     if (result.containsKey("data")) {
  //       Utils.successSnackBar(context, "User Found");
  //       libreUserModel = LibreUserModel.fromMap(result);
  //       await sharedPreferences.setString(AppConstants.libreTokenKey, libreUserModel?.data?.authTicket?.token ?? "");
  //       Navigator.pop(context);
  //       Provider.of<LibreHomeProvider>(context, listen: false).libreGetData(context: context, period: "14", numperiods: "5");
  //     } else {
  //       Utils.errorSnackBar(context, "invalid or expired jwt");
  //     }
  //   } else {
  //     Utils.errorSnackBar(context, "Something went wrong");
  //   }
  //   showOrHideLoader(false);
  //   notifyListeners();
  // }
}
