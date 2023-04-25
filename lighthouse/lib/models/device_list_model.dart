// To parse this JSON data, do
//
//     final deviceListModel = deviceListModelFromMap(jsonString);

import 'dart:convert';

DeviceListModel deviceListModelFromMap(String str) => DeviceListModel.fromMap(json.decode(str));

String deviceListModelToMap(DeviceListModel data) => json.encode(data.toMap());

class DeviceListModel {
  DeviceListModel({
    this.errors,
    this.data,
  });

  List<dynamic>? errors;
  List<HueLight>? data;

  factory DeviceListModel.fromMap(Map<String, dynamic> json) => DeviceListModel(
        errors: json["errors"] == null ? [] : List<dynamic>.from(json["errors"]!.map((x) => x)),
        data: json["data"] == null ? [] : List<HueLight>.from(json["data"]!.map((x) => HueLight.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class HueLight {
  HueLight({
    this.id,
    this.productData,
    this.metadata,
    this.identify,
    this.services,
    this.type,
    this.idV1,
  });

  String? id;
  ProductData? productData;
  Metadata? metadata;
  Identify? identify;
  List<Service>? services;
  String? type;
  String? idV1;

  factory HueLight.fromMap(Map<String, dynamic> json) => HueLight(
        id: json["id"],
        productData: json["product_data"] == null ? null : ProductData.fromMap(json["product_data"]),
        metadata: json["metadata"] == null ? null : Metadata.fromMap(json["metadata"]),
        identify: json["identify"] == null ? null : Identify.fromMap(json["identify"]),
        services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromMap(x))),
        type: json["type"],
        idV1: json["id_v1"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_data": productData?.toMap(),
        "metadata": metadata?.toMap(),
        "identify": identify?.toMap(),
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toMap())),
        "type": type,
        "id_v1": idV1,
      };
}

class Identify {
  Identify();

  factory Identify.fromMap(Map<String, dynamic> json) => Identify();

  Map<String, dynamic> toMap() => {};
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

class ProductData {
  ProductData({
    this.modelId,
    this.manufacturerName,
    this.productName,
    this.productArchetype,
    this.certified,
    this.softwareVersion,
    this.hardwarePlatformType,
  });

  String? modelId;
  String? manufacturerName;
  String? productName;
  String? productArchetype;
  bool? certified;
  String? softwareVersion;
  String? hardwarePlatformType;

  factory ProductData.fromMap(Map<String, dynamic> json) => ProductData(
        modelId: json["model_id"],
        manufacturerName: json["manufacturer_name"],
        productName: json["product_name"],
        productArchetype: json["product_archetype"],
        certified: json["certified"],
        softwareVersion: json["software_version"],
        hardwarePlatformType: json["hardware_platform_type"],
      );

  Map<String, dynamic> toMap() => {
        "model_id": modelId,
        "manufacturer_name": manufacturerName,
        "product_name": productName,
        "product_archetype": productArchetype,
        "certified": certified,
        "software_version": softwareVersion,
        "hardware_platform_type": hardwarePlatformType,
      };
}

class Service {
  Service({
    this.rid,
    this.rtype,
  });

  String? rid;
  String? rtype;

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        rid: json["rid"],
        rtype: json["rtype"],
      );

  Map<String, dynamic> toMap() => {
        "rid": rid,
        "rtype": rtype,
      };
}
