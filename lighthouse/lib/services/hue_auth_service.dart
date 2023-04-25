import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lighthouse/models/link_button_model.dart';
import 'package:lighthouse/models/user_name_model.dart';
import '../helpers/AppUrl.dart';
import '../helpers/Utils.dart';

class HueAuthService {
  static Future<LinkbuttonModel?> configLinkButton({required String token}) async {
    String url = AppUrl.config;
    try {
      var body = {"linkbutton": true};
      log('body: $body');
      log('token: $token');
      var response = await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      log('loginn response: ${response.body}');
      if (response.body.trim() != "Something went wrong") {
        var result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          log(result.toString());
          return LinkbuttonModel.fromMap(result[0]);
        } else if (response.statusCode == 401) {
          Utils.toast('Unauthorized');
          return null;
        } else if (response.statusCode == 500) {
          Utils.toast("Server Error");
          return null;
        }
      } else {
        // Utils.toast("The bridge seems to be offline.");
        return null;
      }
    } on SocketException {
      return null;
    } on TimeoutException catch (e) {
      log('error: $e');
      return null;
    }
    throw {null};
  }

  static Future<UserNameModel?> getApplicationKeyOrUserName({required String token}) async {
    log("getApplicationKeyOrUserName");
    String url = AppUrl.getUserName;
    try {
      var body = {"devicetype": "tapp"};
      log('body: $body');
      var response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token,
      });
      // log('login response: ${response.body}');
      if (response.body != "Something went wrong") {
        var result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          log(result.toString());
          return UserNameModel.fromMap(result[0]);
        } else if (response.statusCode == 401) {
          Utils.toast('Unauthorized');
          return null;
        } else if (response.statusCode == 500) {
          Utils.toast("Server Error");
          return null;
        }
      } else {
        Utils.toast("Something went wrong");
        return null;
      }
    } on SocketException {
      return null;
    } on TimeoutException catch (e) {
      log('error: $e');
      return null;
    }
    throw {null};
  }
}
