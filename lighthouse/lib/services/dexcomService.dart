import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:http/http.dart' as http;
import '../helpers/AppUrl.dart';

class DexcomService {
  static Future<Map<String, dynamic>> addNightScoutUrlService({required String url, required String userId}) async {
    String url = "${AppUrl.nightScoutUrl}$userId/nightscoutUrl";

    var body = {"nightscoutUrl": url};

    dev.log(jsonEncode(body));
    try {
      dev.log('url: $url');
      final uri = Uri.parse(url);
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
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

  static Future<Map<String, dynamic>> getNightScoutdataService({required String userId}) async {
    String url = "${AppUrl.nightScoutUrl}$userId/nightscout-latest";

    dev.log(url);
    try {
      dev.log('url: $url');
      final uri = Uri.parse(url);
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
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

  static Future<Map<String, dynamic>> getNightScouturk({required String userId}) async {
    String url = "${AppUrl.nightScoutUrl}$userId/nightscout-url";

    dev.log(url);
    try {
      dev.log('url: $url');
      final uri = Uri.parse(url);
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
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
