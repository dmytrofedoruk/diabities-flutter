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

    // var body = {"email": "waynemillskidals@gmail.com", "password": "w4tchm4n!"};
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

  static Future<Map<String, dynamic>> librGetMeasurementFromServer({
    required String token,
    required String patientId,
  }) async {
    String url = AppUrl.libreLinkupMeasurementFromServer + patientId;

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

  static Future<dynamic> lightSyncActive({
    required String userid,
  }) async {
    String url = AppUrl.smartLightSyncActive + "/" + userid;
    try {
      dev.log(url);
      var body = {
        "userId": userid,
      };
      dev.log('body: $body');

      var response = await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      dev.log('smartlight active res: ${response.body}');
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
      dev.log('error: $e');
      return null;
    }
    throw {null};
  }

  static Future<dynamic> lightSyncINActive({
    required String userid,
  }) async {
    String url = AppUrl.smartLightSyncINActive + "/" + userid;
    try {
      dev.log(url);
      var body = {
        "userId": userid,
      };
      dev.log('body: $body');

      var response = await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });
      dev.log('smartlight active res: ${response.body}');
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
      dev.log('error: $e');
      return null;
    }
    throw {null};
  }

  static Future<dynamic> smartLightStatus({
    required String userId,
  }) async {
    String url = AppUrl.smartLightSyncStaus + userId;

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
      var result = jsonDecode(response.body);
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
