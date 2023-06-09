// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lighthouse/models/device_list_model.dart';
import 'package:lighthouse/models/lights_server_model.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/services/hue_home_service.dart';
import 'package:lighthouse/views/auth/joining_screens/joinning_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../services/hue_auth_service.dart';
import '../services/hue_device_service.dart';
import '../views/auth/login/loginScreen.dart';
import '../views/hue_home/hue_homeScreen.dart';

class HueProvider with ChangeNotifier {
  HueProvider(this.sharedPreferences);
  TokensModel? tokensModel;
  bool isLoading = false;
  final SharedPreferences sharedPreferences;
  LightsServerModel? lightsServerModel;
  LightsServerModel? newlightsServerModel;
  // DeviceListModel? deviceListModel;
  // DeviceListModel? newdeviceListModel;

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
      isHueToken = false;
      notifyListeners();
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
      getDeviceListFromHue(context);
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      sharedPreferences.setString(AppConstants.HuetokenKey, "");
      isHueToken = false;
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  Future<void> activateOrDEactivateLight({
    required BuildContext context,
    required String deivceId,
    required String deviceName,
    required bool isActive,
  }) async {
    showOrHideLoader(true);

    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var hueApplicationOrUserName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    var userId = sharedPreferences.getString(
      AppConstants.applicationuserIdKey,
    );
    var result = await HueDeviceService.activateOrDEactivateLight(
        userId: userId ?? "",
        deviceID: deivceId,
        hueApplicationKey: hueApplicationOrUserName ?? "",
        deviceName: deviceName,
        authorization: token ?? "",
        isActive: isActive);

    if (result != null) {
      getDeviceListFromServer(context);
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      sharedPreferences.setString(AppConstants.HuetokenKey, "");
      isHueToken = false;
    }
    showOrHideLoader(false);
  }

  Future<List<HueLight>?> getDeviceListFromHue(
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
    var userID = sharedPreferences.getString(
      AppConstants.applicationuserIdKey,
    );
    log("token: $token");
    var result = await HueHomeService.getdeviceList(token: token.toString(), userName: userName.toString(), userId: userID ?? "");
    DeviceListModel? deviceListModel;
    if (result != null) {
      log("get devices succesfully");
      deviceListModel = DeviceListModel.fromMap(result);

      if (deviceListModel != null) {
        if (deviceListModel!.data!.isEmpty) {
          Utils.errorSnackBar(context, "No device found");
        } else {
          if (deviceListModel?.data != null && deviceListModel!.data!.isNotEmpty) {
            log(deviceListModel!.data!.length.toString());
            await saveAllLightsInServer(context: context, ligthslist: deviceListModel!.data);
          }
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

  Future<void> getDeviceListFromServer(
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
    var userID = sharedPreferences.getString(
      AppConstants.applicationuserIdKey,
    );
    log("token: $token");
    var result = await HueDeviceService.getdeviceListFromServer(token: token.toString(), userId: userID ?? "");

    if (result != null) {
      lightsServerModel = LightsServerModel.fromMap(result);
      newlightsServerModel = LightsServerModel.fromMap(result);
      // if (deviceListModel != null) {
      //   log(newdeviceListModel!.data!.length.toString());
      if (lightsServerModel!.hueLights!.isEmpty) {
        Utils.errorSnackBar(context, "No device found");
      }
      //else {

      //   }
      // } else {
      //   Utils.errorSnackBar(context, "Something went wrong");
      // }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  Future<void> saveAllLightsInServer({required BuildContext context, required List<HueLight>? ligthslist}) async {
    showOrHideLoader(true);
    log("saving lights in db");

    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var hueApplicationOrUserName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    var userId = sharedPreferences.getString(
      AppConstants.applicationuserIdKey,
    );
    var result = await HueDeviceService.saveAllLightsIndb(
        userId: userId ?? "", hueApplicationKey: hueApplicationOrUserName ?? "", authorization: token ?? "", lightsList: ligthslist ?? []);

    if (result != null) {
      getDeviceListFromServer(context);
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
      sharedPreferences.setString(AppConstants.HuetokenKey, "");
      isHueToken = false;
    }
    showOrHideLoader(false);
  }

  onItemChanged(String value) {
    log("change called");

    lightsServerModel!.hueLights =
        lightsServerModel!.hueLights!.where((select) => select.lightName!.toLowerCase().contains(value.toLowerCase())).toList();

    log("found items length${lightsServerModel!.hueLights!.length}");
    notifyListeners();
  }

  bool isEmpty = false;
  void showHide() {
    if (lightsServerModel!.hueLights!.isEmpty) {
      isEmpty = true;
      notifyListeners();
    } else {
      isEmpty = false;
      notifyListeners();
    }
  }

  resetList() {
    log("new device added${newlightsServerModel!.hueLights!.length}");
    lightsServerModel!.hueLights = newlightsServerModel!.hueLights;
    notifyListeners();
  }
}
