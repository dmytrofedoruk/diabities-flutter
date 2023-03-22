import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:lighthouse/helpers/Utils.dart';
import 'package:http/http.dart' as http;
import '../helpers/AppUrl.dart';

class LibreAuthService {
  static Future<Map<String, dynamic>> libreLoginService({
    required String email,
    required String password,
  }) async {
    String url = AppUrl.libreLinkupLogin;

    var body = {"email": email, "password": password};

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

  // static Future<Map<String, dynamic>> libreSendOTPService({
  //   required String token,
  // }) async {
  //   String url = AppUrl.libreSendOtp;

  //   var body = {"token": token};

  //   dev.log(jsonEncode(body));
  //   try {
  //     dev.log('url: $url');
  //     final uri = Uri.parse(url);
  //     var response = await http.post(uri,
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json',
  //         },
  //         body: jsonEncode(body));
  //     dev.log(response.body.toString());
  //     Map<String, dynamic> result = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       return result;
  //     } else if (response.statusCode == 401) {
  //       Utils.toast('Unauthorized');
  //       return {'message': 'Unauthorized'};
  //     } else if (response.statusCode == 500) {
  //       return {'message': 'Server Error'};
  //     } else {
  //       Utils.toast("Something went wrong");
  //       return {'message': 'Something went wrong'};
  //     }
  //   } on SocketException {
  //     return {'message': 'Not Connected to the internet'};
  //   } on TimeoutException catch (e) {
  //     return {'message': 'Request timeout'};
  //   } catch (e) {
  //     dev.log(e.toString());
  //     return {'message': e.toString()};
  //   }
  // }

  // static Future<Map<String, dynamic>> libreVerifyOTPService({
  //   required String token,
  //   required String code,
  // }) async {
  //   String url = AppUrl.libreVerifyOtp;

  //   var body = {"token": token, "code": code};

  //   dev.log(jsonEncode(body));
  //   try {
  //     dev.log('url: $url');
  //     final uri = Uri.parse(url);
  //     var response = await http.post(uri,
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json',
  //         },
  //         body: jsonEncode(body));
  //     dev.log(response.body.toString());
  //     Map<String, dynamic> result = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       return result;
  //     } else if (response.statusCode == 401) {
  //       Utils.toast('Unauthorized');
  //       return {'message': 'Unauthorized'};
  //     } else if (response.statusCode == 500) {
  //       return {'message': 'Server Error'};
  //     } else {
  //       Utils.toast("Something went wrong");
  //       return {'message': 'Something went wrong'};
  //     }
  //   } on SocketException {
  //     return {'message': 'Not Connected to the internet'};
  //   } on TimeoutException catch (e) {
  //     return {'message': 'Request timeout'};
  //   } catch (e) {
  //     dev.log(e.toString());
  //     return {'message': e.toString()};
  //   }
  // }

  static Future<Map<String, dynamic>> libreconnection({
    required String token,
  }) async {
    String url = AppUrl.libreLinkupConnection;

    var body = {
      "token": token,
    };

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

  static Future<Map<String, dynamic>> librGetMeasurement({
    required String token,
    required String patientId,
  }) async {
    String url = AppUrl.libreLinkupMeasurement;

    var body = {"patientId": patientId, "token": token};

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
}
