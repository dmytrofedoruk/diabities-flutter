// To parse this JSON data, do
//
//     final libreConnectionModel = libreConnectionModelFromMap(jsonString);

import 'dart:convert';

LibreConnectionModel libreConnectionModelFromMap(String str) => LibreConnectionModel.fromMap(json.decode(str));

String libreConnectionModelToMap(LibreConnectionModel data) => json.encode(data.toMap());

class LibreConnectionModel {
  LibreConnectionModel({
    this.status,
    this.data,
    this.ticket,
  });

  int? status;
  List<Datum>? data;
  Ticket? ticket;

  factory LibreConnectionModel.fromMap(Map<String, dynamic> json) => LibreConnectionModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
        ticket: json["ticket"] == null ? null : Ticket.fromMap(json["ticket"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "ticket": ticket?.toMap(),
      };
}

class Datum {
  Datum({
    this.id,
    this.patientId,
    this.country,
    this.status,
    this.firstName,
    this.lastName,
    this.targetLow,
    this.targetHigh,
    this.uom,
    this.sensor,
    this.alarmRules,
    this.glucoseMeasurement,
    this.glucoseItem,
    this.glucoseAlarm,
    this.patientDevice,
    this.created,
  });

  String? id;
  String? patientId;
  String? country;
  int? status;
  String? firstName;
  String? lastName;
  int? targetLow;
  int? targetHigh;
  int? uom;
  Sensor? sensor;
  AlarmRules? alarmRules;
  Glucose? glucoseMeasurement;
  Glucose? glucoseItem;
  dynamic glucoseAlarm;
  PatientDevice? patientDevice;
  int? created;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        patientId: json["patientId"],
        country: json["country"],
        status: json["status"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        targetLow: json["targetLow"],
        targetHigh: json["targetHigh"],
        uom: json["uom"],
        sensor: json["sensor"] == null ? null : Sensor.fromMap(json["sensor"]),
        alarmRules: json["alarmRules"] == null ? null : AlarmRules.fromMap(json["alarmRules"]),
        glucoseMeasurement: json["glucoseMeasurement"] == null ? null : Glucose.fromMap(json["glucoseMeasurement"]),
        glucoseItem: json["glucoseItem"] == null ? null : Glucose.fromMap(json["glucoseItem"]),
        glucoseAlarm: json["glucoseAlarm"],
        patientDevice: json["patientDevice"] == null ? null : PatientDevice.fromMap(json["patientDevice"]),
        created: json["created"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "patientId": patientId,
        "country": country,
        "status": status,
        "firstName": firstName,
        "lastName": lastName,
        "targetLow": targetLow,
        "targetHigh": targetHigh,
        "uom": uom,
        "sensor": sensor?.toMap(),
        "alarmRules": alarmRules?.toMap(),
        "glucoseMeasurement": glucoseMeasurement?.toMap(),
        "glucoseItem": glucoseItem?.toMap(),
        "glucoseAlarm": glucoseAlarm,
        "patientDevice": patientDevice?.toMap(),
        "created": created,
      };
}

class AlarmRules {
  AlarmRules({
    this.c,
    this.h,
    this.f,
    this.l,
    this.nd,
    this.p,
    this.r,
    this.std,
  });

  bool? c;
  H? h;
  F? f;
  F? l;
  Nd? nd;
  int? p;
  int? r;
  Std? std;

  factory AlarmRules.fromMap(Map<String, dynamic> json) => AlarmRules(
        c: json["c"],
        h: json["h"] == null ? null : H.fromMap(json["h"]),
        f: json["f"] == null ? null : F.fromMap(json["f"]),
        l: json["l"] == null ? null : F.fromMap(json["l"]),
        nd: json["nd"] == null ? null : Nd.fromMap(json["nd"]),
        p: json["p"],
        r: json["r"],
        std: json["std"] == null ? null : Std.fromMap(json["std"]),
      );

  Map<String, dynamic> toMap() => {
        "c": c,
        "h": h?.toMap(),
        "f": f?.toMap(),
        "l": l?.toMap(),
        "nd": nd?.toMap(),
        "p": p,
        "r": r,
        "std": std?.toMap(),
      };
}

class F {
  F({
    this.th,
    this.thmm,
    this.d,
    this.tl,
    this.tlmm,
  });

  int? th;
  double? thmm;
  int? d;
  int? tl;
  double? tlmm;

  factory F.fromMap(Map<String, dynamic> json) => F(
        th: json["th"],
        thmm: json["thmm"]?.toDouble(),
        d: json["d"],
        tl: json["tl"],
        tlmm: json["tlmm"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "th": th,
        "thmm": thmm,
        "d": d,
        "tl": tl,
        "tlmm": tlmm,
      };
}

class H {
  H({
    this.th,
    this.thmm,
    this.d,
    this.f,
  });

  int? th;
  double? thmm;
  int? d;
  double? f;

  factory H.fromMap(Map<String, dynamic> json) => H(
        th: json["th"],
        thmm: json["thmm"]?.toDouble(),
        d: json["d"],
        f: json["f"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "th": th,
        "thmm": thmm,
        "d": d,
        "f": f,
      };
}

class Nd {
  Nd({
    this.i,
    this.r,
    this.l,
  });

  int? i;
  int? r;
  int? l;

  factory Nd.fromMap(Map<String, dynamic> json) => Nd(
        i: json["i"],
        r: json["r"],
        l: json["l"],
      );

  Map<String, dynamic> toMap() => {
        "i": i,
        "r": r,
        "l": l,
      };
}

class Std {
  Std();

  factory Std.fromMap(Map<String, dynamic> json) => Std();

  Map<String, dynamic> toMap() => {};
}

class Glucose {
  Glucose({
    this.factoryTimestamp,
    this.timestamp,
    this.type,
    this.valueInMgPerDl,
    this.trendArrow,
    this.trendMessage,
    this.measurementColor,
    this.glucoseUnits,
    this.value,
    this.isHigh,
    this.isLow,
  });

  String? factoryTimestamp;
  String? timestamp;
  int? type;
  int? valueInMgPerDl;
  int? trendArrow;
  dynamic trendMessage;
  int? measurementColor;
  int? glucoseUnits;
  double? value;
  bool? isHigh;
  bool? isLow;

  factory Glucose.fromMap(Map<String, dynamic> json) => Glucose(
        factoryTimestamp: json["FactoryTimestamp"],
        timestamp: json["Timestamp"],
        type: json["type"],
        valueInMgPerDl: json["ValueInMgPerDl"],
        trendArrow: json["TrendArrow"],
        trendMessage: json["TrendMessage"],
        measurementColor: json["MeasurementColor"],
        glucoseUnits: json["GlucoseUnits"],
        value: json["Value"]?.toDouble(),
        isHigh: json["isHigh"],
        isLow: json["isLow"],
      );

  Map<String, dynamic> toMap() => {
        "FactoryTimestamp": factoryTimestamp,
        "Timestamp": timestamp,
        "type": type,
        "ValueInMgPerDl": valueInMgPerDl,
        "TrendArrow": trendArrow,
        "TrendMessage": trendMessage,
        "MeasurementColor": measurementColor,
        "GlucoseUnits": glucoseUnits,
        "Value": value,
        "isHigh": isHigh,
        "isLow": isLow,
      };
}

class PatientDevice {
  PatientDevice({
    this.did,
    this.dtid,
    this.v,
    this.ll,
    this.hl,
    this.fixedLowAlarmValues,
    this.alarms,
    this.fixedLowThreshold,
  });

  String? did;
  int? dtid;
  String? v;
  int? ll;
  int? hl;
  FixedLowAlarmValues? fixedLowAlarmValues;
  bool? alarms;
  int? fixedLowThreshold;

  factory PatientDevice.fromMap(Map<String, dynamic> json) => PatientDevice(
        did: json["did"],
        dtid: json["dtid"],
        v: json["v"],
        ll: json["ll"],
        hl: json["hl"],
        fixedLowAlarmValues: json["fixedLowAlarmValues"] == null ? null : FixedLowAlarmValues.fromMap(json["fixedLowAlarmValues"]),
        alarms: json["alarms"],
        fixedLowThreshold: json["fixedLowThreshold"],
      );

  Map<String, dynamic> toMap() => {
        "did": did,
        "dtid": dtid,
        "v": v,
        "ll": ll,
        "hl": hl,
        "fixedLowAlarmValues": fixedLowAlarmValues?.toMap(),
        "alarms": alarms,
        "fixedLowThreshold": fixedLowThreshold,
      };
}

class FixedLowAlarmValues {
  FixedLowAlarmValues({
    this.mgdl,
    this.mmoll,
  });

  int? mgdl;
  double? mmoll;

  factory FixedLowAlarmValues.fromMap(Map<String, dynamic> json) => FixedLowAlarmValues(
        mgdl: json["mgdl"],
        mmoll: json["mmoll"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "mgdl": mgdl,
        "mmoll": mmoll,
      };
}

class Sensor {
  Sensor({
    this.deviceId,
    this.sn,
    this.a,
    this.w,
    this.pt,
    this.s,
    this.lj,
  });

  String? deviceId;
  String? sn;
  int? a;
  int? w;
  int? pt;
  bool? s;
  bool? lj;

  factory Sensor.fromMap(Map<String, dynamic> json) => Sensor(
        deviceId: json["deviceId"],
        sn: json["sn"],
        a: json["a"],
        w: json["w"],
        pt: json["pt"],
        s: json["s"],
        lj: json["lj"],
      );

  Map<String, dynamic> toMap() => {
        "deviceId": deviceId,
        "sn": sn,
        "a": a,
        "w": w,
        "pt": pt,
        "s": s,
        "lj": lj,
      };
}

class Ticket {
  Ticket({
    this.token,
    this.expires,
    this.duration,
  });

  String? token;
  int? expires;
  int? duration;

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        token: json["token"],
        expires: json["expires"],
        duration: json["duration"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "expires": expires,
        "duration": duration,
      };
}
