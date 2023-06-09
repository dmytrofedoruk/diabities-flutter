// To parse this JSON data, do
//
//     final emergencyNumberModel = emergencyNumberModelFromMap(jsonString);

import 'dart:convert';

EmergencyNumberModel emergencyNumberModelFromMap(String str) => EmergencyNumberModel.fromMap(json.decode(str));

String emergencyNumberModelToMap(EmergencyNumberModel data) => json.encode(data.toMap());

class EmergencyNumberModel {
  List<String>? phoneNumbers;

  EmergencyNumberModel({
    this.phoneNumbers,
  });

  factory EmergencyNumberModel.fromMap(Map<String, dynamic> json) => EmergencyNumberModel(
        phoneNumbers: json["phoneNumbers"] == null ? [] : List<String>.from(json["phoneNumbers"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "phoneNumbers": phoneNumbers == null ? [] : List<dynamic>.from(phoneNumbers!.map((x) => x)),
      };
}
