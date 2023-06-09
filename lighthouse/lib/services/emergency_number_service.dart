import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../helpers/AppUrl.dart';
import '../helpers/Utils.dart';

class EmergencyNumberService {
  static Future<dynamic> addEmergencyNumbers({required String userid, required List<String> numbers}) async {
    String url = AppUrl.emergencyNumbers;
    try {
      log(url);
      var body = {"userId": userid, "phoneNumbers": numbers};
      log('body: $body');

      var response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      log('add emrgency number response: ${response.body}');
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

  static Future<dynamic> emergencycallingActive({
    required String userid,
  }) async {
    String url = AppUrl.emergencyActive;
    try {
      log(url);
      var body = {
        "userId": userid,
      };
      log('body: $body');

      var response = await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      log('add emrgency calling Active response: ${response.body}');
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

  static Future<dynamic> emergencycallingINActive({
    required String userid,
  }) async {
    String url = AppUrl.emergencyInActive;
    try {
      log(url);
      var body = {
        "userId": userid,
      };
      log('body: $body');

      var response = await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      log('add emrgency calling inactive res: ${response.body}');
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

  static Future<dynamic> getEmergencyNumbers({required String userid}) async {
    String url = "${AppUrl.emergencyNumbers}/$userid";
    try {
      log(url);

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      log('get emergency nubners response: ${response.body}');
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

  static Future<dynamic> getEmergencyCallingStaus({required String userid}) async {
    String url = "${AppUrl.emergencyCallingStatus}/$userid";
    try {
      log(url);

      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      log('get emergency nubners response: ${response.body}');
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
}
