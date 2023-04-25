import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../helpers/AppUrl.dart';
import '../helpers/Utils.dart';

class AppAuthService {
  static Future<dynamic> loginInAppLighHouse({required String email, required String password}) async {
    String url = AppUrl.loginInLightHouse;
    try {
      var body = {"email": email, "password": password};
      log('body: $body');

      var response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      log('login response: ${response.body}');
      if (response.body != "Something went wrong") {
        var result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return result;
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

  static Future<dynamic> signUpApi({required String email, required String password, required String name}) async {
    String url = AppUrl.signupInLightHouse;
    try {
      var body = {"email": email, "password": password, "name": name};
      log('body: $body');

      var response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      log('login response: ${response.body}');
      if (response.body != "Something went wrong") {
        var result = jsonDecode(response.body);
        if (response.statusCode == 200) {
          return result;
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

  static Future<dynamic> checkAppSubScription({required String email, required String password, required String token}) async {
    String url = AppUrl.subscriptionCheckLightHouse;
    try {
      var body = {"email": email, "password": password};
      log('body: $body');
      log('checking token: $token');

      var response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      });
      log('login response: ${response.body}');
      if (response.body != "Something went wrong") {
        var result = jsonDecode(response.body);
        log(response.statusCode.toString());
        if (response.statusCode == 200) {
          return result;
        } else if (response.statusCode == 401) {
          Utils.toast('Unauthorized');
          return null;
        } else if (response.statusCode == 500) {
          Utils.toast("Server Error");
          return null;
        } else if (response.statusCode == 404) {
          Utils.toast("Customer Not Found");
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
