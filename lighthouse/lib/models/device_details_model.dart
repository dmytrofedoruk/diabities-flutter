// To parse this JSON data, do
//
//     final deviceDetailsModel = deviceDetailsModelFromMap(jsonString);

import 'dart:convert';

DeviceDetailsModel deviceDetailsModelFromMap(String str) => DeviceDetailsModel.fromMap(json.decode(str));

String deviceDetailsModelToMap(DeviceDetailsModel data) => json.encode(data.toMap());

class DeviceDetailsModel {
  DeviceDetailsModel({
    this.errors,
    this.data,
  });

  List<dynamic>? errors;
  List<Device>? data;

  factory DeviceDetailsModel.fromMap(Map<String, dynamic> json) => DeviceDetailsModel(
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
        data: json["data"] == null ? [] : List<Device>.from(json["data"]!.map((x) => Device.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Device {
  Device({
    this.id,
    this.idV1,
    this.owner,
    this.metadata,
    this.on,
    this.dimming,
    this.dimmingDelta,
    this.colorTemperature,
    this.colorTemperatureDelta,
    this.color,
    this.dynamics,
    this.alert,
    this.signaling,
    this.mode,
    this.powerup,
    this.type,
    this.rgb,
  });

  String? id;
  String? idV1;
  Owner? owner;
  Metadata? metadata;
  DeviceOn? on;
  DeviceDimming? dimming;
  ColorTemperatureDelta? dimmingDelta;
  DeviceColorTemperature? colorTemperature;
  ColorTemperatureDelta? colorTemperatureDelta;
  DeviceColor? color;
  Dynamics? dynamics;
  Alert? alert;
  ColorTemperatureDelta? signaling;
  String? mode;
  Powerup? powerup;
  String? type;
  Rgb? rgb;

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        id: json["id"],
        idV1: json["id_v1"],
        owner: json["owner"] == null ? null : Owner.fromMap(json["owner"]),
        metadata: json["metadata"] == null ? null : Metadata.fromMap(json["metadata"]),
        on: json["on"] == null ? null : DeviceOn.fromMap(json["on"]),
        dimming: json["dimming"] == null ? null : DeviceDimming.fromMap(json["dimming"]),
        dimmingDelta: json["dimming_delta"] == null ? null : ColorTemperatureDelta.fromMap(json["dimming_delta"]),
        colorTemperature: json["color_temperature"] == null ? null : DeviceColorTemperature.fromMap(json["color_temperature"]),
        colorTemperatureDelta: json["color_temperature_delta"] == null ? null : ColorTemperatureDelta.fromMap(json["color_temperature_delta"]),
        color: json["color"] == null ? null : DeviceColor.fromMap(json["color"]),
        dynamics: json["dynamics"] == null ? null : Dynamics.fromMap(json["dynamics"]),
        alert: json["alert"] == null ? null : Alert.fromMap(json["alert"]),
        signaling: json["signaling"] == null ? null : ColorTemperatureDelta.fromMap(json["signaling"]),
        mode: json["mode"],
        powerup: json["powerup"] == null ? null : Powerup.fromMap(json["powerup"]),
        type: json["type"],
        rgb: json["rgb"] == null ? null : Rgb.fromMap(json["rgb"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "id_v1": idV1,
        "owner": owner?.toMap(),
        "metadata": metadata?.toMap(),
        "on": on?.toMap(),
        "dimming": dimming?.toMap(),
        "dimming_delta": dimmingDelta?.toMap(),
        "color_temperature": colorTemperature?.toMap(),
        "color_temperature_delta": colorTemperatureDelta?.toMap(),
        "color": color?.toMap(),
        "dynamics": dynamics?.toMap(),
        "alert": alert?.toMap(),
        "signaling": signaling?.toMap(),
        "mode": mode,
        "powerup": powerup?.toMap(),
        "type": type,
      };
}

class Alert {
  Alert({
    this.actionValues,
  });

  List<String>? actionValues;

  factory Alert.fromMap(Map<String, dynamic> json) => Alert(
        actionValues: json["action_values"] == null ? [] : List<String>.from(json["action_values"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "action_values": actionValues == null ? [] : List<dynamic>.from(actionValues!.map((x) => x)),
      };
}

class DeviceColor {
  DeviceColor({
    this.xy,
    this.gamut,
    this.gamutType,
  });

  Xy? xy;
  Gamut? gamut;
  String? gamutType;

  factory DeviceColor.fromMap(Map<String, dynamic> json) => DeviceColor(
        xy: json["xy"] == null ? null : Xy.fromMap(json["xy"]),
        gamut: json["gamut"] == null ? null : Gamut.fromMap(json["gamut"]),
        gamutType: json["gamut_type"],
      );

  Map<String, dynamic> toMap() => {
        "xy": xy?.toMap(),
        "gamut": gamut?.toMap(),
        "gamut_type": gamutType,
      };
}

class Gamut {
  Gamut({
    this.red,
    this.green,
    this.blue,
  });

  Xy? red;
  Xy? green;
  Xy? blue;

  factory Gamut.fromMap(Map<String, dynamic> json) => Gamut(
        red: json["red"] == null ? null : Xy.fromMap(json["red"]),
        green: json["green"] == null ? null : Xy.fromMap(json["green"]),
        blue: json["blue"] == null ? null : Xy.fromMap(json["blue"]),
      );

  Map<String, dynamic> toMap() => {
        "red": red?.toMap(),
        "green": green?.toMap(),
        "blue": blue?.toMap(),
      };
}

class Xy {
  Xy({
    this.x,
    this.y,
  });

  double? x;
  double? y;

  factory Xy.fromMap(Map<String, dynamic> json) => Xy(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "x": x,
        "y": y,
      };
}

class DeviceColorTemperature {
  DeviceColorTemperature({
    this.mirek,
    this.mirekValid,
    this.mirekSchema,
  });

  dynamic mirek;
  bool? mirekValid;
  MirekSchema? mirekSchema;

  factory DeviceColorTemperature.fromMap(Map<String, dynamic> json) => DeviceColorTemperature(
        mirek: json["mirek"],
        mirekValid: json["mirek_valid"],
        mirekSchema: json["mirek_schema"] == null ? null : MirekSchema.fromMap(json["mirek_schema"]),
      );

  Map<String, dynamic> toMap() => {
        "mirek": mirek,
        "mirek_valid": mirekValid,
        "mirek_schema": mirekSchema?.toMap(),
      };
}

class MirekSchema {
  MirekSchema({
    this.mirekMinimum,
    this.mirekMaximum,
  });

  int? mirekMinimum;
  int? mirekMaximum;

  factory MirekSchema.fromMap(Map<String, dynamic> json) => MirekSchema(
        mirekMinimum: json["mirek_minimum"],
        mirekMaximum: json["mirek_maximum"],
      );

  Map<String, dynamic> toMap() => {
        "mirek_minimum": mirekMinimum,
        "mirek_maximum": mirekMaximum,
      };
}

class ColorTemperatureDelta {
  ColorTemperatureDelta();

  factory ColorTemperatureDelta.fromMap(Map<String, dynamic> json) => ColorTemperatureDelta();

  Map<String, dynamic> toMap() => {};
}

class DeviceDimming {
  DeviceDimming({
    this.brightness,
    this.minDimLevel,
  });

  dynamic? brightness;
  double? minDimLevel;

  factory DeviceDimming.fromMap(Map<String, dynamic> json) => DeviceDimming(
        brightness: json["brightness"].toDouble(),
        minDimLevel: json["min_dim_level"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "brightness": brightness?.toDouble(),
        "min_dim_level": minDimLevel,
      };
}

class Dynamics {
  Dynamics({
    this.status,
    this.statusValues,
    this.speed,
    this.speedValid,
  });

  String? status;
  List<String>? statusValues;
  int? speed;
  bool? speedValid;

  factory Dynamics.fromMap(Map<String, dynamic> json) => Dynamics(
        status: json["status"],
        statusValues: json["status_values"] == null ? [] : List<String>.from(json["status_values"]!.map((x) => x)),
        speed: json["speed"],
        speedValid: json["speed_valid"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "status_values": statusValues == null ? [] : List<dynamic>.from(statusValues!.map((x) => x)),
        "speed": speed,
        "speed_valid": speedValid,
      };
}

class Metadata {
  Metadata({
    this.name,
    this.archetype,
  });

  String? name;
  String? archetype;

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata(
        name: json["name"],
        archetype: json["archetype"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "archetype": archetype,
      };
}

class DeviceOn {
  DeviceOn({
    this.on,
  });

  bool? on;

  factory DeviceOn.fromMap(Map<String, dynamic> json) => DeviceOn(
        on: json["on"],
      );

  Map<String, dynamic> toMap() => {
        "on": on,
      };
}

class Owner {
  Owner({
    this.rid,
    this.rtype,
  });

  String? rid;
  String? rtype;

  factory Owner.fromMap(Map<String, dynamic> json) => Owner(
        rid: json["rid"],
        rtype: json["rtype"],
      );

  Map<String, dynamic> toMap() => {
        "rid": rid,
        "rtype": rtype,
      };
}

class Powerup {
  Powerup({
    this.preset,
    this.configured,
    this.on,
    this.dimming,
    this.color,
  });

  String? preset;
  bool? configured;
  PowerupOn? on;
  PowerupDimming? dimming;
  PowerupColor? color;

  factory Powerup.fromMap(Map<String, dynamic> json) => Powerup(
        preset: json["preset"],
        configured: json["configured"],
        on: json["on"] == null ? null : PowerupOn.fromMap(json["on"]),
        dimming: json["dimming"] == null ? null : PowerupDimming.fromMap(json["dimming"]),
        color: json["color"] == null ? null : PowerupColor.fromMap(json["color"]),
      );

  Map<String, dynamic> toMap() => {
        "preset": preset,
        "configured": configured,
        "on": on?.toMap(),
        "dimming": dimming?.toMap(),
        "color": color?.toMap(),
      };
}

class PowerupColor {
  PowerupColor({
    this.mode,
    this.colorTemperature,
  });

  String? mode;
  ColorColorTemperature? colorTemperature;

  factory PowerupColor.fromMap(Map<String, dynamic> json) => PowerupColor(
        mode: json["mode"],
        colorTemperature: json["color_temperature"] == null ? null : ColorColorTemperature.fromMap(json["color_temperature"]),
      );

  Map<String, dynamic> toMap() => {
        "mode": mode,
        "color_temperature": colorTemperature?.toMap(),
      };
}

class ColorColorTemperature {
  ColorColorTemperature({
    this.mirek,
  });

  int? mirek;

  factory ColorColorTemperature.fromMap(Map<String, dynamic> json) => ColorColorTemperature(
        mirek: json["mirek"],
      );

  Map<String, dynamic> toMap() => {
        "mirek": mirek,
      };
}

class PowerupDimming {
  PowerupDimming({
    this.mode,
    this.dimming,
  });

  String? mode;
  DimmingDimming? dimming;

  factory PowerupDimming.fromMap(Map<String, dynamic> json) => PowerupDimming(
        mode: json["mode"],
        dimming: json["dimming"] == null ? null : DimmingDimming.fromMap(json["dimming"]),
      );

  Map<String, dynamic> toMap() => {
        "mode": mode,
        "dimming": dimming?.toMap(),
      };
}

class DimmingDimming {
  DimmingDimming({
    this.brightness,
  });

  int? brightness;

  factory DimmingDimming.fromMap(Map<String, dynamic> json) => DimmingDimming(
        brightness: json["brightness"],
      );

  Map<String, dynamic> toMap() => {
        "brightness": brightness,
      };
}

class PowerupOn {
  PowerupOn({
    this.mode,
    this.on,
  });

  String? mode;
  DeviceOn? on;

  factory PowerupOn.fromMap(Map<String, dynamic> json) => PowerupOn(
        mode: json["mode"],
        on: json["on"] == null ? null : DeviceOn.fromMap(json["on"]),
      );

  Map<String, dynamic> toMap() => {
        "mode": mode,
        "on": on?.toMap(),
      };
}

class Rgb {
  Rgb({
    this.r,
    this.g,
    this.b,
  });

  int? r;
  double? g;
  double? b;

  factory Rgb.fromMap(Map<String, dynamic> json) => Rgb(
        r: json["r"],
        g: json["g"]?.toDouble(),
        b: json["b"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "r": r,
        "g": g,
        "b": b,
      };
}
