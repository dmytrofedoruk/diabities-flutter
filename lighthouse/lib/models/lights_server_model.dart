import 'dart:convert';

LightsServerModel lightsServerModelFromMap(String str) => LightsServerModel.fromMap(json.decode(str));

String lightsServerModelToMap(LightsServerModel data) => json.encode(data.toMap());

class LightsServerModel {
  List<HueServerLight>? hueLights;

  LightsServerModel({
    this.hueLights,
  });

  factory LightsServerModel.fromMap(Map<String, dynamic> json) => LightsServerModel(
        hueLights: json["hueLights"] == null ? [] : List<HueServerLight>.from(json["hueLights"]!.map((x) => HueServerLight.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "hueLights": hueLights == null ? [] : List<dynamic>.from(hueLights!.map((x) => x.toMap())),
      };
}

class HueServerLight {
  int? id;
  String? userId;
  String? lightId;
  String? hueApplicationKey;
  String? authorization;
  bool? active;
  String? lightName;
  bool? isOn;

  HueServerLight({
    this.id,
    this.userId,
    this.lightId,
    this.hueApplicationKey,
    this.authorization,
    this.active,
    this.lightName,
    this.isOn = false,
  });

  factory HueServerLight.fromMap(Map<String, dynamic> json) => HueServerLight(
        id: json["id"],
        userId: json["user_id"],
        lightId: json["light_id"],
        hueApplicationKey: json["hue-application-key"],
        authorization: json["Authorization"],
        active: json["active"],
        lightName: json["light_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "light_id": lightId,
        "hue-application-key": hueApplicationKey,
        "Authorization": authorization,
        "active": active,
        "light_name": lightName,
      };
}
