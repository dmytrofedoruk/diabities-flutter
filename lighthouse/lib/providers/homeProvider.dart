// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/models/device_list_model.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/services/hue_home_service.dart';
import 'package:lighthouse/views/auth/joining_screens/joinning_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../services/hue_auth_service.dart';
import '../views/auth/login/loginScreen.dart';
import '../views/hue_home/hue_homeScreen.dart';

class HueProvider with ChangeNotifier {
  HueProvider(this.sharedPreferences);
  TokensModel? tokensModel;
  bool isLoading = false;
  final SharedPreferences sharedPreferences;
  DeviceListModel? deviceListModel;
  DeviceListModel? newdeviceListModel;

  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  void logOut(BuildContext context) {
    sharedPreferences.setString(AppConstants.ApplicationtokenKey, "");
    sharedPreferences.setString(AppConstants.HuetokenKey, "");
    sharedPreferences.setString(AppConstants.userNameKey, "");
    sharedPreferences.setString(AppConstants.refreshtokenKey, "");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const JoiningScreen()), (Route<dynamic> route) => false);
  }

  bool isHueToken = false;

  Future<bool> canpressLoginButton() async {
    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );

    if (token != null && token.isNotEmpty) {
      isHueToken = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> pressLinkButton(
    BuildContext context,
  ) async {
    bool returnvalue = false;
    isHueToken = true;
    showOrHideLoader(true);

    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var result = await HueAuthService.configLinkButton(token: token.toString());
    showOrHideLoader(false);

    if (result != null) {
      log("Link button pressed succesfully");
      showOrHideLoader(false);
      returnvalue = true;
    } else {
      log("configLinkButton " + result.toString());
      isHueToken = false;

      await sharedPreferences.setString(AppConstants.HuetokenKey, "");

      returnvalue = false;
      notifyListeners();
    }
    return returnvalue;
  }

  Future<void> getApplicationKeyOrUserName(
    BuildContext context,
  ) async {
    showOrHideLoader(true);
    notifyListeners();
    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var result = await HueAuthService.getApplicationKeyOrUserName(token: token.toString());

    if (result != null) {
      sharedPreferences.setString(AppConstants.userNameKey, result.success?.username ?? "");
      log(result.success?.username ?? "");
      getDeviceList(context);
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      sharedPreferences.setString(AppConstants.HuetokenKey, "");
      isHueToken = false;
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  Future<List<HueLight>?> getDeviceList(
    BuildContext context,
  ) async {
    showOrHideLoader(true);
    notifyListeners();
    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    var result = await HueHomeService.getdeviceList(token: token.toString(), userName: userName.toString());

    if (result != null) {
      log("get devices succesfully");
      deviceListModel = DeviceListModel.fromMap(result);
      newdeviceListModel = DeviceListModel.fromMap(result);
      if (deviceListModel != null) {
        log(newdeviceListModel!.data!.length.toString());
        if (deviceListModel!.data!.isEmpty) {
          Utils.errorSnackBar(context, "No device found");
        }
      } else {
        Utils.errorSnackBar(context, "Something went wrong");
      }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
    }
    showOrHideLoader(false);
    notifyListeners();
    return deviceListModel!.data;
  }

  onItemChanged(String value) {
    log("change called");

    deviceListModel!.data = deviceListModel!.data!.where((select) => select.metadata!.name!.toLowerCase().contains(value.toLowerCase())).toList();

    log("found items length" + deviceListModel!.data!.length.toString());
    notifyListeners();
  }

  bool isEmpty = false;
  void showHide() {
    if (deviceListModel!.data!.isEmpty) {
      isEmpty = true;
      notifyListeners();
    } else {
      isEmpty = false;
      notifyListeners();
    }
  }

  resetList() {
    log("new device added" + newdeviceListModel!.data!.length.toString());
    deviceListModel!.data = newdeviceListModel!.data;
    notifyListeners();
  }
}
