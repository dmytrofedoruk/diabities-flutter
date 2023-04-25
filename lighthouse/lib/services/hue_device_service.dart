import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:lighthouse/helpers/colorHelper.dart';

import '../helpers/AppUrl.dart';

class HueDeviceService {
  static Future<Map<String, dynamic>> getdeviceDetails({required String token, required deviceID, required String userName}) async {
    String url = AppUrl.light + deviceID;
    try {
      dev.log('url: $url');
      final uri = Uri.parse(url);
      var response = await http.get(uri, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'hue-application-key': userName,
        'Authorization': token,
      });
      dev.log(response.body.toString());
      Map<String, dynamic> result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else if (response.statusCode == 401) {
        Utils.toast('Unauthorized');
        return {'message': 'Unauthorized'};
      } else if (response.statusCode == 500) {
        return {'message': 'Server Error'};
      } else {
        Utils.toast("Something went wrong");
        return {'message': 'Something went wrong'};
      }
    } on SocketException {
      return {'message': 'Not Connected to the internet'};
    } on TimeoutException catch (e) {
      return {'message': 'Request timeout'};
    }
  }

  static Future<Map<String, dynamic>> turnOnOrOffLight(
      {required String token, required String deviceID, required bool isturnOn, required String userName}) async {
    String onOrOff = isturnOn ? "/on" : "/off";
    String url = AppUrl.light + deviceID + onOrOff;
    try {
      dev.log('url: $url');
      final uri = Uri.parse(url);
      var response = await http.put(uri, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'hue-application-key': userName,
        'Authorization': token,
      });
      dev.log(response.body.toString());
      Map<String, dynamic> result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else if (response.statusCode == 401) {
        Utils.toast('Unauthorized');
        return {'message': 'Unauthorized'};
      } else if (response.statusCode == 500) {
        return {'message': 'Server Error'};
      } else {
        Utils.toast("Something went wrong");
        return {'message': 'Something went wrong'};
      }
    } on SocketException {
      return {'message': 'Not Connected to the internet'};
    } on TimeoutException catch (e) {
      return {'message': 'Request timeout'};
    }
  }

  static Future<Map<String, dynamic>> changeColorLight(
      {required String token, required String deviceID, required double brightness, required String userName, required Color color}) async {
    String url = AppUrl.lights + deviceID;
    ColorHelper colorHelper = ColorHelper();
    final colors = colorHelper.rgbToXY(color.red, color.green, color.blue);
    dev.log(colors.xy.toString());

    dev.inspect(color);
    var body = {"colorX": colors.xy!.first, "colorY": colors.xy!.last, "brightness": brightness};

    dev.log(jsonEncode(body));
    try {
      dev.log('url: $url');
      final uri = Uri.parse(url);
      var response = await http.put(uri,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'hue-application-key': userName,
            'Authorization': token,
          },
          body: jsonEncode(body));
      dev.log(response.body.toString());
      Map<String, dynamic> result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else if (response.statusCode == 401) {
        Utils.toast('Unauthorized');
        return {'message': 'Unauthorized'};
      } else if (response.statusCode == 500) {
        return {'message': 'Server Error'};
      } else {
        Utils.toast("Something went wrong");
        return {'message': 'Something went wrong'};
      }
    } on SocketException {
      return {'message': 'Not Connected to the internet'};
    } on TimeoutException catch (e) {
      return {'message': 'Request timeout'};
    } catch (e) {
      dev.log(e.toString());
      return {'message': e.toString()};
    }
  }
}
