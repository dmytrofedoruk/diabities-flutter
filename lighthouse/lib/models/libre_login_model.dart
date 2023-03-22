// To parse this JSON data, do
//
//     final libreLoginModel = libreLoginModelFromMap(jsonString);

import 'dart:convert';

LibreLoginModel libreLoginModelFromMap(String str) => LibreLoginModel.fromMap(json.decode(str));

String libreLoginModelToMap(LibreLoginModel data) => json.encode(data.toMap());

class LibreLoginModel {
  LibreLoginModel({
    this.status,
    this.data,
  });

  int? status;
  Data? data;

  factory LibreLoginModel.fromMap(Map<String, dynamic> json) => LibreLoginModel(
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
  Details? practices;
  Details? devices;
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
        practices: json["practices"] == null ? null : Details.fromMap(json["practices"]),
        devices: json["devices"] == null ? null : Details.fromMap(json["devices"]),
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
        "devices": devices?.toMap(),
        "consents": consents?.toMap(),
      };
}

class Consents {
  Consents({
    this.llu,
  });

  Llu? llu;

  factory Consents.fromMap(Map<String, dynamic> json) => Consents(
        llu: json["llu"] == null ? null : Llu.fromMap(json["llu"]),
      );

  Map<String, dynamic> toMap() => {
        "llu": llu?.toMap(),
      };
}

class Llu {
  Llu({
    this.policyAccept,
    this.touAccept,
  });

  int? policyAccept;
  int? touAccept;

  factory Llu.fromMap(Map<String, dynamic> json) => Llu(
        policyAccept: json["policyAccept"],
        touAccept: json["touAccept"],
      );

  Map<String, dynamic> toMap() => {
        "policyAccept": policyAccept,
        "touAccept": touAccept,
      };
}

class Details {
  Details();

  factory Details.fromMap(Map<String, dynamic> json) => Details();

  Map<String, dynamic> toMap() => {};
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
    this.lluGettingStartedBanner,
    this.lluNewFeatureModal,
    this.lluOnboarding,
    this.lvWebPostRelease,
  });

  int? firstUsePhoenix;
  int? firstUsePhoenixReportsDataMerged;
  int? lluGettingStartedBanner;
  int? lluNewFeatureModal;
  int? lluOnboarding;
  String? lvWebPostRelease;

  factory SystemMessages.fromMap(Map<String, dynamic> json) => SystemMessages(
        firstUsePhoenix: json["firstUsePhoenix"],
        firstUsePhoenixReportsDataMerged: json["firstUsePhoenixReportsDataMerged"],
        lluGettingStartedBanner: json["lluGettingStartedBanner"],
        lluNewFeatureModal: json["lluNewFeatureModal"],
        lluOnboarding: json["lluOnboarding"],
        lvWebPostRelease: json["lvWebPostRelease"],
      );

  Map<String, dynamic> toMap() => {
        "firstUsePhoenix": firstUsePhoenix,
        "firstUsePhoenixReportsDataMerged": firstUsePhoenixReportsDataMerged,
        "lluGettingStartedBanner": lluGettingStartedBanner,
        "lluNewFeatureModal": lluNewFeatureModal,
        "lluOnboarding": lluOnboarding,
        "lvWebPostRelease": lvWebPostRelease,
      };
}

class TwoFactor {
  TwoFactor({
    this.primaryMethod,
    this.primaryValue,
    this.secondaryMethod,
    this.secondaryValue,
  });

  String? primaryMethod;
  String? primaryValue;
  String? secondaryMethod;
  String? secondaryValue;

  factory TwoFactor.fromMap(Map<String, dynamic> json) => TwoFactor(
        primaryMethod: json["primaryMethod"],
        primaryValue: json["primaryValue"],
        secondaryMethod: json["secondaryMethod"],
        secondaryValue: json["secondaryValue"],
      );

  Map<String, dynamic> toMap() => {
        "primaryMethod": primaryMethod,
        "primaryValue": primaryValue,
        "secondaryMethod": secondaryMethod,
        "secondaryValue": secondaryValue,
      };
}
