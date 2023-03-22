// To parse this JSON data, do
//
//     final userNameModel = userNameModelFromMap(jsonString);

import 'dart:convert';

List<UserNameModel> userNameModelFromMap(String str) => List<UserNameModel>.from(json.decode(str).map((x) => UserNameModel.fromMap(x)));

String userNameModelToMap(List<UserNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserNameModel {
  UserNameModel({
    this.success,
  });

  Success? success;

  factory UserNameModel.fromMap(Map<String, dynamic> json) => UserNameModel(
        success: json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success?.toMap(),
      };
}

class Success {
  Success({
    this.username,
  });

  String? username;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        username: json["username"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "username": username,
      };
}
