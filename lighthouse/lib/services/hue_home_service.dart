import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:lighthouse/helpers/Utils.dart';
import 'package:http/http.dart' as http;

import '../helpers/AppUrl.dart';

class HueHomeService {
  static Future<Map<String, dynamic>> getdeviceList({required String token, required String userName}) async {
    String url = AppUrl.devicesList;
    try {
      log('url: $url');
      final uri = Uri.parse(url);
      var response = await http.get(uri, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'hue-application-key': userName,
        'Authorization': token,
      });
      log(response.body.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
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
}
