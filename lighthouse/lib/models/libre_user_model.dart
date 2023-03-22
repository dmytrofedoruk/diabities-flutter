// To parse this JSON data, do
//
//     final libreUserModel = libreUserModelFromMap(jsonString);

import 'dart:convert';

LibreUserModel libreUserModelFromMap(String str) => LibreUserModel.fromMap(json.decode(str));

String libreUserModelToMap(LibreUserModel data) => json.encode(data.toMap());

class LibreUserModel {
  LibreUserModel({
    this.status,
    this.data,
  });

  int? status;
  Data? data;

  factory LibreUserModel.fromMap(Map<String, dynamic> json) => LibreUserModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
      };
}

class Data {
  Data({
    this.user,
    this.messages,
    this.notifications,
    this.authTicket,
    this.invitations,
    this.trustedDeviceToken,
  });

  User? user;
  DataMessages? messages;
  Notifications? notifications;
  AuthTicket? authTicket;
  dynamic invitations;
  String? trustedDeviceToken;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        messages: json["messages"] == null ? null : DataMessages.fromMap(json["messages"]),
        notifications: json["notifications"] == null ? null : Notifications.fromMap(json["notifications"]),
        authTicket: json["authTicket"] == null ? null : AuthTicket.fromMap(json["authTicket"]),
        invitations: json["invitations"],
        trustedDeviceToken: json["trustedDeviceToken"],
      );

  Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
        "messages": messages?.toMap(),
        "notifications": notifications?.toMap(),
        "authTicket": authTicket?.toMap(),
        "invitations": invitations,
        "trustedDeviceToken": trustedDeviceToken,
      };
}

class AuthTicket {
  AuthTicket({
    this.token,
    this.expires,
    this.duration,
  });

  String? token;
  int? expires;
  int? duration;

  factory AuthTicket.fromMap(Map<String, dynamic> json) => AuthTicket(
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

class DataMessages {
  DataMessages({
    this.unread,
  });

  int? unread;

  factory DataMessages.fromMap(Map<String, dynamic> json) => DataMessages(
        unread: json["unread"],
      );

  Map<String, dynamic> toMap() => {
        "unread": unread,
      };
}

class Notifications {
  Notifications({
    this.unresolved,
  });

  int? unresolved;

  factory Notifications.fromMap(Map<String, dynamic> json) => Notifications(
        unresolved: json["unresolved"],
      );

  Map<String, dynamic> toMap() => {
        "unresolved": unresolved,
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.uiLanguage,
    this.communicationLanguage,
    this.accountType,
    this.uom,
    this.dateFormat,
    this.timeFormat,
    this.emailDay,
    this.system,
    this.details,
    this.twoFactor,
    this.created,
    this.lastLogin,
    this.programs,
    this.dateOfBirth,
    this.practices,
    this.devices,
    this.consents,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? country;
  String? uiLanguage;
  String? communicationLanguage;
  String? accountType;
  String? uom;
  String? dateFormat;
  String? timeFormat;
  List<int>? emailDay;
  System? system;
  Details? details;
  TwoFactor? twoFactor;
  int? created;
  int? lastLogin;
  Details? programs;
  int? dateOfBirth;
  Practices? practices;
  Map<String, Device>? devices;
  Consents? consents;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        country: json["country"],
        uiLanguage: json["uiLanguage"],
        communicationLanguage: json["communicationLanguage"],
        accountType: json["accountType"],
        uom: json["uom"],
        dateFormat: json["dateFormat"],
        timeFormat: json["timeFormat"],
        emailDay: json["emailDay"] == null ? [] : List<int>.from(json["emailDay"]!.map((x) => x)),
        system: json["system"] == null ? null : System.fromMap(json["system"]),
        details: json["details"] == null ? null : Details.fromMap(json["details"]),
        twoFactor: json["twoFactor"] == null ? null : TwoFactor.fromMap(json["twoFactor"]),
        created: json["created"],
        lastLogin: json["lastLogin"],
        programs: json["programs"] == null ? null : Details.fromMap(json["programs"]),
        dateOfBirth: json["dateOfBirth"],
        practices: json["practices"] == null ? null : Practices.fromMap(json["practices"]),
        devices: Map.from(json["devices"]!).map((k, v) => MapEntry<String, Device>(k, Device.fromMap(v))),
        consents: json["consents"] == null ? null : Consents.fromMap(json["consents"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "country": country,
        "uiLanguage": uiLanguage,
        "communicationLanguage": communicationLanguage,
        "accountType": accountType,
        "uom": uom,
        "dateFormat": dateFormat,
        "timeFormat": timeFormat,
        "emailDay": emailDay == null ? [] : List<dynamic>.from(emailDay!.map((x) => x)),
        "system": system?.toMap(),
        "details": details?.toMap(),
        "twoFactor": twoFactor?.toMap(),
        "created": created,
        "lastLogin": lastLogin,
        "programs": programs?.toMap(),
        "dateOfBirth": dateOfBirth,
        "practices": practices?.toMap(),
        "devices": Map.from(devices!).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "consents": consents?.toMap(),
      };
}

class Consents {
  Consents({
    this.realWorldEvidence,
  });

  RealWorldEvidence? realWorldEvidence;

  factory Consents.fromMap(Map<String, dynamic> json) => Consents(
        realWorldEvidence: json["realWorldEvidence"] == null ? null : RealWorldEvidence.fromMap(json["realWorldEvidence"]),
      );

  Map<String, dynamic> toMap() => {
        "realWorldEvidence": realWorldEvidence?.toMap(),
      };
}

class RealWorldEvidence {
  RealWorldEvidence({
    this.policyAccept,
    this.touAccept,
    this.history,
  });

  int? policyAccept;
  int? touAccept;
  List<History>? history;

  factory RealWorldEvidence.fromMap(Map<String, dynamic> json) => RealWorldEvidence(
        policyAccept: json["policyAccept"],
        touAccept: json["touAccept"],
        history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "policyAccept": policyAccept,
        "touAccept": touAccept,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toMap())),
      };
}

class History {
  History({
    this.policyAccept,
  });

  int? policyAccept;

  factory History.fromMap(Map<String, dynamic> json) => History(
        policyAccept: json["policyAccept"],
      );

  Map<String, dynamic> toMap() => {
        "policyAccept": policyAccept,
      };
}

class Details {
  Details();

  factory Details.fromMap(Map<String, dynamic> json) => Details();

  Map<String, dynamic> toMap() => {};
}

class Device {
  Device({
    this.id,
    this.nickname,
    this.sn,
    this.type,
    this.uploadDate,
  });

  String? id;
  String? nickname;
  String? sn;
  int? type;
  int? uploadDate;

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        id: json["id"],
        nickname: json["nickname"],
        sn: json["sn"],
        type: json["type"],
        uploadDate: json["uploadDate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nickname": nickname,
        "sn": sn,
        "type": type,
        "uploadDate": uploadDate,
      };
}

class Practices {
  Practices({
    this.the22A547242E2711Ea967F0242Ac110002,
  });

  The22A547242E2711Ea967F0242Ac110002? the22A547242E2711Ea967F0242Ac110002;

  factory Practices.fromMap(Map<String, dynamic> json) => Practices(
        the22A547242E2711Ea967F0242Ac110002: json["22a54724-2e27-11ea-967f-0242ac110002"] == null
            ? null
            : The22A547242E2711Ea967F0242Ac110002.fromMap(json["22a54724-2e27-11ea-967f-0242ac110002"]),
      );

  Map<String, dynamic> toMap() => {
        "22a54724-2e27-11ea-967f-0242ac110002": the22A547242E2711Ea967F0242Ac110002?.toMap(),
      };
}

class The22A547242E2711Ea967F0242Ac110002 {
  The22A547242E2711Ea967F0242Ac110002({
    this.id,
    this.practiceId,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zip,
    this.phoneNumber,
    this.records,
  });

  String? id;
  String? practiceId;
  String? name;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  String? phoneNumber;
  dynamic records;

  factory The22A547242E2711Ea967F0242Ac110002.fromMap(Map<String, dynamic> json) => The22A547242E2711Ea967F0242Ac110002(
        id: json["id"],
        practiceId: json["practiceId"],
        name: json["name"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        phoneNumber: json["phoneNumber"],
        records: json["records"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "practiceId": practiceId,
        "name": name,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "zip": zip,
        "phoneNumber": phoneNumber,
        "records": records,
      };
}

class System {
  System({
    this.messages,
  });

  SystemMessages? messages;

  factory System.fromMap(Map<String, dynamic> json) => System(
        messages: json["messages"] == null ? null : SystemMessages.fromMap(json["messages"]),
      );

  Map<String, dynamic> toMap() => {
        "messages": messages?.toMap(),
      };
}

class SystemMessages {
  SystemMessages({
    this.firstUsePhoenix,
    this.firstUsePhoenixReportsDataMerged,
    this.lvWebPostRelease,
  });

  int? firstUsePhoenix;
  int? firstUsePhoenixReportsDataMerged;
  String? lvWebPostRelease;

  factory SystemMessages.fromMap(Map<String, dynamic> json) => SystemMessages(
        firstUsePhoenix: json["firstUsePhoenix"],
        firstUsePhoenixReportsDataMerged: json["firstUsePhoenixReportsDataMerged"],
        lvWebPostRelease: json["lvWebPostRelease"],
      );

  Map<String, dynamic> toMap() => {
        "firstUsePhoenix": firstUsePhoenix,
        "firstUsePhoenixReportsDataMerged": firstUsePhoenixReportsDataMerged,
        "lvWebPostRelease": lvWebPostRelease,
      };
}

class TwoFactor {
  TwoFactor({
    this.primaryMethod,
    this.primaryValue,
    this.secondaryMethod,
    this.secondaryValue,
    this.trustedDevices,
  });

  String? primaryMethod;
  String? primaryValue;
  String? secondaryMethod;
  String? secondaryValue;
  TrustedDevices? trustedDevices;

  factory TwoFactor.fromMap(Map<String, dynamic> json) => TwoFactor(
        primaryMethod: json["primaryMethod"],
        primaryValue: json["primaryValue"],
        secondaryMethod: json["secondaryMethod"],
        secondaryValue: json["secondaryValue"],
        trustedDevices: json["trustedDevices"] == null ? null : TrustedDevices.fromMap(json["trustedDevices"]),
      );

  Map<String, dynamic> toMap() => {
        "primaryMethod": primaryMethod,
        "primaryValue": primaryValue,
        "secondaryMethod": secondaryMethod,
        "secondaryValue": secondaryValue,
        "trustedDevices": trustedDevices?.toMap(),
      };
}

class TrustedDevices {
  TrustedDevices({
    this.dd64Ac443Fe03C22A99F5E1F8Ad8C9Be,
  });

  Dd64Ac443Fe03C22A99F5E1F8Ad8C9Be? dd64Ac443Fe03C22A99F5E1F8Ad8C9Be;

  factory TrustedDevices.fromMap(Map<String, dynamic> json) => TrustedDevices(
        dd64Ac443Fe03C22A99F5E1F8Ad8C9Be: json["dd64ac443fe03c22a99f5e1f8ad8c9be"] == null
            ? null
            : Dd64Ac443Fe03C22A99F5E1F8Ad8C9Be.fromMap(json["dd64ac443fe03c22a99f5e1f8ad8c9be"]),
      );

  Map<String, dynamic> toMap() => {
        "dd64ac443fe03c22a99f5e1f8ad8c9be": dd64Ac443Fe03C22A99F5E1F8Ad8C9Be?.toMap(),
      };
}

class Dd64Ac443Fe03C22A99F5E1F8Ad8C9Be {
  Dd64Ac443Fe03C22A99F5E1F8Ad8C9Be({
    this.created,
    this.deviceToken,
    this.nickname,
    this.updated,
  });

  int? created;
  String? deviceToken;
  String? nickname;
  int? updated;

  factory Dd64Ac443Fe03C22A99F5E1F8Ad8C9Be.fromMap(Map<String, dynamic> json) => Dd64Ac443Fe03C22A99F5E1F8Ad8C9Be(
        created: json["created"],
        deviceToken: json["deviceToken"],
        nickname: json["nickname"],
        updated: json["updated"],
      );

  Map<String, dynamic> toMap() => {
        "created": created,
        "deviceToken": deviceToken,
        "nickname": nickname,
        "updated": updated,
      };
}
