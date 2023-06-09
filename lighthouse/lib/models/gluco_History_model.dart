// // class GlucoHistoryModel {
//   GlucoHistoryModel({
//     this.status,
//     this.data,
//     this.ticket,
//   });

//   int? status;
//   GlucoHistoryModelData? data;
//   Ticket? ticket;

//   factory GlucoHistoryModel.fromMap(Map<String, dynamic> json) => GlucoHistoryModel(
//         status: json["status"],
//         data: json["data"] == null ? null : GlucoHistoryModelData.fromMap(json["data"]),
//         ticket: json["ticket"] == null ? null : Ticket.fromMap(json["ticket"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "status": status,
//         "data": data?.toMap(),
//         "ticket": ticket?.toMap(),
//       };
// }

// class GlucoHistoryModelData {
//   GlucoHistoryModelData({
//     this.lastUpload,
//     this.lastUploadCgm,
//     this.lastUploadPro,
//     this.reminderSent,
//     this.devices,
//     this.periods,
//   });

//   int? lastUpload;
//   int? lastUploadCgm;
//   int? lastUploadPro;
//   int? reminderSent;
//   List<int>? devices;
//   List<Period>? periods;

//   factory GlucoHistoryModelData.fromMap(Map<String, dynamic> json) => GlucoHistoryModelData(
//         lastUpload: json["lastUpload"],
//         lastUploadCgm: json["lastUploadCGM"],
//         lastUploadPro: json["lastUploadPro"],
//         reminderSent: json["reminderSent"],
//         devices: json["devices"] == null ? [] : List<int>.from(json["devices"]!.map((x) => x)),
//         periods: json["periods"] == null ? [] : List<Period>.from(json["periods"]!.map((x) => Period.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "lastUpload": lastUpload,
//         "lastUploadCGM": lastUploadCgm,
//         "lastUploadPro": lastUploadPro,
//         "reminderSent": reminderSent,
//         "devices": devices == null ? [] : List<dynamic>.from(devices!.map((x) => x)),
//         "periods": periods == null ? [] : List<dynamic>.from(periods!.map((x) => x.toMap())),
//       };
// }

// class Period {
//   Period({
//     this.dateEnd,
//     this.dateStart,
//     this.noData,
//     this.dataType,
//     this.avgGlucose,
//     this.serialNumber,
//     this.deviceId,
//     this.deviceType,
//     this.mergeableDevices,
//     this.hypoEvents,
//     this.avgTestsPerDay,
//     this.daysOfData,
//     this.data,
//   });

//   int? dateEnd;
//   int? dateStart;
//   bool? noData;
//   String? dataType;
//   double? avgGlucose;
//   String? serialNumber;
//   String? deviceId;
//   int? deviceType;
//   List<MergeableDevice>? mergeableDevices;
//   int? hypoEvents;
//   int? avgTestsPerDay;
//   int? daysOfData;
//   PeriodData? data;

//   factory Period.fromMap(Map<String, dynamic> json) => Period(
//         dateEnd: json["dateEnd"],
//         dateStart: json["dateStart"],
//         noData: json["noData"],
//         dataType: json["dataType"],
//         avgGlucose: json["avgGlucose"]?.toDouble(),
//         serialNumber: json["serialNumber"],
//         deviceId: json["deviceId"],
//         deviceType: json["deviceType"],
//         mergeableDevices:
//             json["mergeableDevices"] == null ? [] : List<MergeableDevice>.from(json["mergeableDevices"]!.map((x) => MergeableDevice.fromMap(x))),
//         hypoEvents: json["hypoEvents"],
//         avgTestsPerDay: json["avgTestsPerDay"],
//         daysOfData: json["daysOfData"],
//         data: json["data"] == null ? null : PeriodData.fromMap(json["data"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "dateEnd": dateEnd,
//         "dateStart": dateStart,
//         "noData": noData,
//         "dataType": dataType,
//         "avgGlucose": avgGlucose,
//         "serialNumber": serialNumber,
//         "deviceId": deviceId,
//         "deviceType": deviceType,
//         "mergeableDevices": mergeableDevices == null ? [] : List<dynamic>.from(mergeableDevices!.map((x) => x.toMap())),
//         "hypoEvents": hypoEvents,
//         "avgTestsPerDay": avgTestsPerDay,
//         "daysOfData": daysOfData,
//         "data": data?.toMap(),
//       };
// }

// class PeriodData {
//   PeriodData({
//     this.maxGlucoseRange,
//     this.minGlucoseRange,
//     this.maxGlucoseValue,
//     this.blocks,
//   });

//   double? maxGlucoseRange;
//   double? minGlucoseRange;
//   double? maxGlucoseValue;
//   List<List<Block>>? blocks;

//   factory PeriodData.fromMap(Map<String, dynamic> json) => PeriodData(
//         maxGlucoseRange: json["maxGlucoseRange"]?.toDouble(),
//         minGlucoseRange: json["minGlucoseRange"]?.toDouble(),
//         maxGlucoseValue: json["maxGlucoseValue"]?.toDouble(),
//         blocks: json["blocks"] == null ? [] : List<List<Block>>.from(json["blocks"]!.map((x) => List<Block>.from(x.map((x) => Block.fromMap(x))))),
//       );

//   Map<String, dynamic> toMap() => {
//         "maxGlucoseRange": maxGlucoseRange,
//         "minGlucoseRange": minGlucoseRange,
//         "maxGlucoseValue": maxGlucoseValue,
//         "blocks": blocks == null ? [] : List<dynamic>.from(blocks!.map((x) => List<dynamic>.from(x.map((x) => x.toMap())))),
//       };
// }

// class Block {
//   Block({
//     this.time,
//     this.percentile5,
//     this.percentile25,
//     this.percentile50,
//     this.percentile75,
//     this.percentile95,
//   });

//   int? time;
//   double? percentile5;
//   double? percentile25;
//   double? percentile50;
//   double? percentile75;
//   double? percentile95;

//   factory Block.fromMap(Map<String, dynamic> json) => Block(
//         time: json["time"],
//         percentile5: json["percentile5"]?.toDouble(),
//         percentile25: json["percentile25"]?.toDouble(),
//         percentile50: json["percentile50"]?.toDouble(),
//         percentile75: json["percentile75"]?.toDouble(),
//         percentile95: json["percentile95"]?.toDouble(),
//       );

//   Map<String, dynamic> toMap() => {
//         "time": time,
//         "percentile5": percentile5,
//         "percentile25": percentile25,
//         "percentile50": percentile50,
//         "percentile75": percentile75,
//         "percentile95": percentile95,
//       };
// }

// class MergeableDevice {
//   MergeableDevice({
//     this.id,
//     this.created,
//     this.updated,
//     this.patientId,
//     this.deviceTypeId,
//     this.serialNumber,
//     this.lastUpload,
//     this.deviceId,
//   });

//   String? id;
//   int? created;
//   int? updated;
//   String? patientId;
//   int? deviceTypeId;
//   String? serialNumber;
//   int? lastUpload;
//   String? deviceId;

//   factory MergeableDevice.fromMap(Map<String, dynamic> json) => MergeableDevice(
//         id: json["id"],
//         created: json["created"],
//         updated: json["updated"],
//         patientId: json["patientId"],
//         deviceTypeId: json["deviceTypeId"],
//         serialNumber: json["serialNumber"],
//         lastUpload: json["lastUpload"],
//         deviceId: json["DeviceID"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "created": created,
//         "updated": updated,
//         "patientId": patientId,
//         "deviceTypeId": deviceTypeId,
//         "serialNumber": serialNumber,
//         "lastUpload": lastUpload,
//         "DeviceID": deviceId,
//       };
// }

// class Ticket {
//   Ticket({
//     this.token,
//     this.expires,
//     this.duration,
//   });

//   String? token;
//   int? expires;
//   int? duration;

//   factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
//         token: json["token"],
//         expires: json["expires"],
//         duration: json["duration"],
//       );

//   Map<String, dynamic> toMap() => {
//         "token": token,
//         "expires": expires,
//         "duration": duration,
//       };
// }
// To parse this JSON data, do
//
//     final glucoHistoryModel = glucoHistoryModelFromMap(jsonString);

import 'dart:convert';

GlucoHistoryModel glucoHistoryModelFromMap(String str) => GlucoHistoryModel.fromMap(json.decode(str));

String glucoHistoryModelToMap(GlucoHistoryModel data) => json.encode(data.toMap());

class GlucoHistoryModel {
  GlucoHistoryModel({
    this.status,
    this.data,
    this.ticket,
  });

  int? status;
  Data? data;
  Ticket? ticket;

  factory GlucoHistoryModel.fromMap(Map<String, dynamic> json) => GlucoHistoryModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        ticket: json["ticket"] == null ? null : Ticket.fromMap(json["ticket"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
        "ticket": ticket?.toMap(),
      };
}

class Data {
  Data({
    this.connection,
    this.activeSensors,
    this.graphData,
  });

  Connection? connection;
  List<ActiveSensor>? activeSensors;
  List<GraphDatum>? graphData;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        connection: json["connection"] == null ? null : Connection.fromMap(json["connection"]),
        activeSensors: json["activeSensors"] == null ? [] : List<ActiveSensor>.from(json["activeSensors"]!.map((x) => ActiveSensor.fromMap(x))),
        graphData: json["graphData"] == null ? [] : List<GraphDatum>.from(json["graphData"]!.map((x) => GraphDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "connection": connection?.toMap(),
        "activeSensors": activeSensors == null ? [] : List<dynamic>.from(activeSensors!.map((x) => x.toMap())),
        "graphData": graphData == null ? [] : List<dynamic>.from(graphData!.map((x) => x.toMap())),
      };
}

class ActiveSensor {
  ActiveSensor({
    this.sensor,
    this.device,
  });

  Sensor? sensor;
  Device? device;

  factory ActiveSensor.fromMap(Map<String, dynamic> json) => ActiveSensor(
        sensor: json["sensor"] == null ? null : Sensor.fromMap(json["sensor"]),
        device: json["device"] == null ? null : Device.fromMap(json["device"]),
      );

  Map<String, dynamic> toMap() => {
        "sensor": sensor?.toMap(),
        "device": device?.toMap(),
      };
}

class Device {
  Device({
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

  factory Device.fromMap(Map<String, dynamic> json) => Device(
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

class Connection {
  Connection({
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
  GraphDatum? glucoseMeasurement;
  GraphDatum? glucoseItem;
  dynamic glucoseAlarm;
  Device? patientDevice;
  int? created;

  factory Connection.fromMap(Map<String, dynamic> json) => Connection(
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
        glucoseMeasurement: json["glucoseMeasurement"] == null ? null : GraphDatum.fromMap(json["glucoseMeasurement"]),
        glucoseItem: json["glucoseItem"] == null ? null : GraphDatum.fromMap(json["glucoseItem"]),
        glucoseAlarm: json["glucoseAlarm"],
        patientDevice: json["patientDevice"] == null ? null : Device.fromMap(json["patientDevice"]),
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

class GraphDatum {
  GraphDatum({
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
  DateTime? timestamp;
  int? type;
  int? valueInMgPerDl;
  int? trendArrow;
  dynamic trendMessage;
  int? measurementColor;
  int? glucoseUnits;
  double? value;
  String? isHigh;
  String? isLow;

  factory GraphDatum.fromMap(Map<String, dynamic> json) => GraphDatum(
        factoryTimestamp: json["FactoryTimestamp"],
        timestamp: DateTime.parse(json["timestamp"]),
        type: int.parse(json["type"].toString()),
        valueInMgPerDl: json["ValueInMgPerDl"],
        trendArrow: json["TrendArrow"],
        trendMessage: json["TrendMessage"],
        measurementColor: int.parse(json["MeasurementColor"].toString()),
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
