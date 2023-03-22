import 'dart:convert';

List<LinkbuttonModel> linkbuttonModelFromMap(String str) => List<LinkbuttonModel>.from(json.decode(str).map((x) => LinkbuttonModel.fromMap(x)));

String linkbuttonModelToMap(List<LinkbuttonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class LinkbuttonModel {
  LinkbuttonModel({
    this.success,
  });

  Success? success;

  factory LinkbuttonModel.fromMap(Map<String, dynamic> json) => LinkbuttonModel(
        success: json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success?.toMap(),
      };
}

class Success {
  Success({
    this.configLinkbutton,
  });

  bool? configLinkbutton;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        configLinkbutton: json["/config/linkbutton"],
      );

  Map<String, dynamic> toMap() => {
        "/config/linkbutton": configLinkbutton,
      };
}
