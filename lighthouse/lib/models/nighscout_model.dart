// To parse this JSON data, do
//
//     final nightScoutModel = nightScoutModelFromMap(jsonString);

import 'dart:convert';

NightScoutModel nightScoutModelFromMap(String str) => NightScoutModel.fromMap(json.decode(str));

String nightScoutModelToMap(NightScoutModel data) => json.encode(data.toMap());

class NightScoutModel {
  List<ReadingDetails>? data;

  NightScoutModel({
    this.data,
  });

  factory NightScoutModel.fromMap(Map<String, dynamic> json) => NightScoutModel(
        data: json["data"] == null ? [] : List<ReadingDetails>.from(json["data"]!.map((x) => ReadingDetails.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ReadingDetails {
  int? id;
  String? device;
  String? date;
  DateTime? dateString;
  int? sgv;
  int? delta;
  String? direction;
  String? type;
  int? filtered;
  int? unfiltered;
  int? rssi;
  int? noise;
  DateTime? sysTime;
  int? utcOffset;
  String? userId;

  ReadingDetails({
    this.id,
    this.device,
    this.date,
    this.dateString,
    this.sgv,
    this.delta,
    this.direction,
    this.type,
    this.filtered,
    this.unfiltered,
    this.rssi,
    this.noise,
    this.sysTime,
    this.utcOffset,
    this.userId,
  });

  factory ReadingDetails.fromMap(Map<String, dynamic> json) => ReadingDetails(
        id: json["id"],
        device: json["device"],
        date: json["date"],
        dateString: json["date_string"] == null ? null : DateTime.parse(json["date_string"]),
        sgv: json["sgv"],
        delta: json["delta"],
        direction: json["direction"],
        type: json["type"],
        filtered: json["filtered"],
        unfiltered: json["unfiltered"],
        rssi: json["rssi"],
        noise: json["noise"],
        sysTime: json["sys_time"] == null ? null : DateTime.parse(json["sys_time"]),
        utcOffset: json["utc_offset"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "device": device,
        "date": date,
        "date_string": dateString?.toIso8601String(),
        "sgv": sgv,
        "delta": delta,
        "direction": direction,
        "type": type,
        "filtered": filtered,
        "unfiltered": unfiltered,
        "rssi": rssi,
        "noise": noise,
        "sys_time": sysTime?.toIso8601String(),
        "utc_offset": utcOffset,
        "user_id": userId,
      };
}
