// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/services/emergency_number_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../models/emergencyNumbersModel.dart';

class EmergencyCallProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  EmergencyCallProvider(this.sharedPreferences);
  bool isLoading = false;

  EmergencyNumberModel? emergencyNumberModel;
  bool emergencyCallingActive = false;

  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  Future<void> addEmergencyNumbers({
    required BuildContext context,
    required List<String> numbersList,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await EmergencyNumberService.addEmergencyNumbers(userid: userId ?? "", numbers: numbersList);

    if (result != null) {
      Utils.successSnackBar(context, result["message"]);
    } else {
      log("error$result");
      Utils.errorSnackBar(context, "Failed to save emergency numbers.");
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> emergencycallingActive({
    required BuildContext context,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await EmergencyNumberService.emergencycallingActive(userid: userId ?? "");

    if (result != null) {
      Utils.successSnackBar(context, result["message"]);
    } else {
      log("error$result");
      Utils.errorSnackBar(context, result["message"]);
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> emergencycallingInActive({
    required BuildContext context,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await EmergencyNumberService.emergencycallingINActive(userid: userId ?? "");

    if (result != null) {
      Utils.successSnackBar(context, result["message"]);
    } else {
      log("error$result");
      Utils.errorSnackBar(context, result["message"]);
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> getEmergencyNumbers({
    required BuildContext context,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await EmergencyNumberService.getEmergencyNumbers(userid: userId ?? "");

    if (result != null) {
      log(result.toString());
      emergencyNumberModel = emergencyNumberModelFromMap(jsonEncode(result));
    } else {
      log("error$result");
      Utils.errorSnackBar(context, "Some thing went wrong");
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }

  Future<void> getEmergencyCallingStaus({
    required BuildContext context,
  }) async {
    showOrHideLoader(true);
    String? userId = sharedPreferences.getString(AppConstants.applicationuserIdKey);

    var result = await EmergencyNumberService.getEmergencyCallingStaus(userid: userId ?? "");

    if (result != null) {
      log(result.toString());
      emergencyCallingActive = result["active"] == 1 ? true : false;
      notifyListeners();
    } else {
      log("error$result");
      Utils.errorSnackBar(context, "Some thing went wrong");
      showOrHideLoader(false);
    }

    showOrHideLoader(false);
  }
}
