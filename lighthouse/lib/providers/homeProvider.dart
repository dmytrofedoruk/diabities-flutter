// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/models/device_list_model.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/services/home_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../services/auth_service.dart';
import '../views/auth/login/loginScreen.dart';
import '../views/home/homeScreen.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider(this.sharedPreferences);
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
    sharedPreferences.setString(AppConstants.tokenKey, "");
    sharedPreferences.setString(AppConstants.userNameKey, "");
    sharedPreferences.setString(AppConstants.refreshtokenKey, "");
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
  }

  bool isHueToken = false;

  Future<bool> canpressLoginButton() async {
    var token = sharedPreferences.getString(
      AppConstants.tokenKey,
    );

    if (token != null && token.isNotEmpty) {
      isHueToken = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> pressLinkButton(
    BuildContext context,
  ) async {
    isHueToken = true;
    showOrHideLoader(true);

    var token = sharedPreferences.getString(
      AppConstants.tokenKey,
    );
    var result = await AuthService.configLinkButton(token: token.toString());

    if (result != null) {
      log("Link button pressed succesfully");
    } else {
      log(result.toString());
      Utils.errorSnackBar(context, "Something went wrong");
      sharedPreferences.setString(AppConstants.tokenKey, "");
      isHueToken = false;
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  Future<void> getApplicationKeyOrUserName(
    BuildContext context,
  ) async {
    showOrHideLoader(true);
    notifyListeners();
    var token = sharedPreferences.getString(
      AppConstants.tokenKey,
    );
    var result = await AuthService.getApplicationKeyOrUserName(token: token.toString());

    if (result != null) {
      sharedPreferences.setString(AppConstants.userNameKey, result.success?.username ?? "");
      log(result.success?.username ?? "");
      getDeviceList(context);
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      sharedPreferences.setString(AppConstants.tokenKey, "");
      isHueToken = false;
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  Future<void> getDeviceList(
    BuildContext context,
  ) async {
    showOrHideLoader(true);
    notifyListeners();
    var token = sharedPreferences.getString(
      AppConstants.tokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    var result = await HomeService.getdeviceList(token: token.toString(), userName: userName.toString());

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
  }

  onItemChanged(String value) {
    log("change called");

    deviceListModel!.data = deviceListModel!.data!.where((select) => select.metadata!.name!.toLowerCase().startsWith(value.toLowerCase())).toList();

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
