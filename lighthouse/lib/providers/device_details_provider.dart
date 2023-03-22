// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:hue_dart/hue_dart.dart';
import 'package:lighthouse/models/device_details_model.dart';
import 'package:lighthouse/models/token_model.dart';
import 'package:lighthouse/services/device_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/AppConstants.dart';
import '../helpers/Utils.dart';

class DeviceDetailsProvider with ChangeNotifier {
  DeviceDetailsProvider(this.sharedPreferences);
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

  // Color getColor(Device device) {
  //   double x = device.color!.xy!.x!; // the given x value
  //   double y = device.color!.xy!.y!; // the given y value
  //   // log(x.toString());
  //   // log(y.toString());
  //   double z = 1.0 - x - y;
  //   double Y = device.dimming?.brightness?.toDouble() ?? 100.0; // The given brightness value
  //   double X = (Y / y) * x;
  //   double Z = (Y / y) * z;

  //   double r = X * 1.656492 - Y * 0.354851 - Z * 0.255038;
  //   double g = -X * 0.707196 + Y * 1.655397 + Z * 0.036152;
  //   double b = X * 0.051713 - Y * 0.121364 + Z * 1.011530;
  //   // log(r.toString());
  //   // log(g.toString());
  //   // log(b.toString());
  //   // r = r <= 0.0031308 ? 12.92 * r : (1.0 + 0.055) * math.pow(r, (1.0 / 2.4)) - 0.055;
  //   // g = g <= 0.0031308 ? 12.92 * g : (1.0 + 0.055) * math.pow(g, (1.0 / 2.4)) - 0.055;
  //   // b = b <= 0.0031308 ? 12.92 * b : (1.0 + 0.055) * math.pow(b, (1.0 / 2.4)) - 0.055;

  //   r = r * 255.0;
  //   g = g * 255.0;
  //   b = b * 255.0;
  //   log(r.toString());
  //   log(g.toString());
  //   log(b.toString());

  //   return Color.fromRGBO(r.round(), g.round(), b.round(), 1.0);
  // }

  Future<void> getDeviceDetails({
    required BuildContext context,
    required String deviceId,
  }) async {
    showOrHideLoader(true);
    deviceDetailsModel = null;
    var token = sharedPreferences.getString(
      AppConstants.tokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    log("userName: $userName");
    var result = await DeviceService.getdeviceDetails(token: token.toString(), deviceID: deviceId, userName: userName.toString());

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
  }

  Future<void> turnOnOrOffLight({
    required BuildContext context,
    required String deviceId,
    required bool isOn,
  }) async {
    showOrHideLoader(true);
    notifyListeners();
    var token = sharedPreferences.getString(
      AppConstants.tokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    log("userName: $userName");
    var result = await DeviceService.turnOnOrOffLight(token: token.toString(), deviceID: deviceId, userName: userName.toString(), isturnOn: isOn);

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

  getcolor(double Xvalue, double yValue, double brightness) {
    double x = Xvalue; // the given x value
    double y = yValue; // the given y value
    double z = 1.0 - x - y;
    double Y = brightness; // The given brightness value
    double X = (Y / y) * x;
    double Z = (Y / y) * z;

    double r = X * 1.656492 - Y * 0.354851 - Z * 0.255038;
    double g = -X * 0.707196 + Y * 1.655397 + Z * 0.036152;
    double b = X * 0.051713 - Y * 0.121364 + Z * 1.011530;

    r = r <= 0.0031308 ? 12.92 * r : (1.0 + 0.055) * math.pow(r, (1.0 / 2.4)) - 0.055;
    g = g <= 0.0031308 ? 12.92 * g : (1.0 + 0.055) * math.pow(g, (1.0 / 2.4)) - 0.055;
    b = b <= 0.0031308 ? 12.92 * b : (1.0 + 0.055) * math.pow(b, (1.0 / 2.4)) - 0.055;
    log(r.toString());
    log(g.toString());
    log(b.toString());
    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);
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
      AppConstants.tokenKey,
    );
    var userName = sharedPreferences.getString(
      AppConstants.userNameKey,
    );
    log("token: $token");
    log("userName: $userName");
    var result = await DeviceService.changeColorLight(
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
