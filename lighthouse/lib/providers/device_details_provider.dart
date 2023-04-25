// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:lighthouse/models/device_details_model.dart';
import 'package:lighthouse/models/token_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';
import '../services/hue_device_service.dart';

class HueDeviceDetailsProvider with ChangeNotifier {
  HueDeviceDetailsProvider(this.sharedPreferences);
  TokensModel? tokensModel;
  bool isLoading = false;
  final SharedPreferences sharedPreferences;
  DeviceDetailsModel? deviceDetailsModel;

  showOrHideLoader(bool isShow) {
    if (isShow) {
      isLoading = true;
    } else {
      isLoading = false;
    }

    notifyListeners();
  }

  Future<DeviceDetailsModel?> getDeviceDetails({
    required BuildContext context,
    required String deviceId,
  }) async {
    showOrHideLoader(true);
    deviceDetailsModel = null;
    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    log("userName: $userName");
    var result = await HueDeviceService.getdeviceDetails(token: token.toString(), deviceID: deviceId, userName: userName.toString());

    if (result != null) {
      log("get device details succesfully");
      deviceDetailsModel = DeviceDetailsModel.fromMap(result);
      if (deviceDetailsModel != null) {
        log(deviceDetailsModel!.data!.length.toString());
      }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
    }
    showOrHideLoader(false);
    notifyListeners();
   return deviceDetailsModel;
  }

  Future<void> turnOnOrOffLight({
    required BuildContext context,
    required String deviceId,
    required bool isOn,
  }) async {
    showOrHideLoader(true);
    notifyListeners();
    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    log("userName: $userName");
    var result = await HueDeviceService.turnOnOrOffLight(token: token.toString(), deviceID: deviceId, userName: userName.toString(), isturnOn: isOn);

    if (result != null) {
      inspect(result["errors"]);
      List errors = result["errors"];
      if (errors.isNotEmpty) {
        Utils.errorSnackBar(context, result["errors"][0]['description']);
      }
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
    }
    showOrHideLoader(false);
    notifyListeners();
  }

  Color xyToRgb(double x, double y, double brightness) {
    // Calculate XYZ values
    double z = 1 - x - y;
    double Y = brightness;
    double X = (Y / y) * x;
    double Z = (Y / y) * z;

    // Convert to linear RGB values
    double Rlinear = X * 3.2406 + Y * -1.5372 + Z * -0.4986;
    double Glinear = X * -0.9689 + Y * 1.8758 + Z * 0.0415;
    double Blinear = X * 0.0557 + Y * -0.2040 + Z * 1.0570;

    // Apply gamma correction
    double gamma = 2.4;
    int R = (255 * (Rlinear <= 0.0031308 ? 12.92 * Rlinear : math.pow((1 + 0.055) * Rlinear, 1.0 / gamma) - 0.055)).round();
    int G = (255 * (Glinear <= 0.0031308 ? 12.92 * Glinear : math.pow((1 + 0.055) * Glinear, 1.0 / gamma) - 0.055)).round();
    int B = (255 * (Blinear <= 0.0031308 ? 12.92 * Blinear : math.pow((1 + 0.055) * Blinear, 1.0 / gamma) - 0.055)).round();

    // Return RGB color as list of integers
    return Color.fromRGBO(R, G, B, 1);
  }

  Future<void> changeLightColors({
    required BuildContext context,
    required String deviceID,
    required double brightness,
    required Color color,
  }) async {
    showOrHideLoader(true);
    notifyListeners();
    var token = sharedPreferences.getString(
      AppConstants.HuetokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    log("userName: $userName");
    var result = await HueDeviceService.changeColorLight(
        token: token.toString(), deviceID: deviceID, userName: userName.toString(), brightness: brightness, color: color);

    if (result != null) {
      log(result.runtimeType.toString());
      List errors = result["errors"];
      if (errors.isNotEmpty) {
        Utils.errorSnackBar(context, result["errors"][0]['description']);
      }
      log(result.toString());
    } else {
      Utils.errorSnackBar(context, "Something went wrong");
    }
    showOrHideLoader(false);
    notifyListeners();
  }
}
