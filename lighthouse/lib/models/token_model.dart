// To parse this JSON data, do
//
//     final tokensModel = tokensModelFromMap(jsonString);

import 'dart:convert';

TokensModel tokensModelFromMap(String str) => TokensModel.fromMap(json.decode(str));

String tokensModelToMap(TokensModel data) => json.encode(data.toMap());

class TokensModel {
  TokensModel({
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.tokenType,
  });

  String? accessToken;
  int? expiresIn;
  String? refreshToken;
  String? tokenType;

  factory TokensModel.fromMap(Map<String, dynamic> json) => TokensModel(
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "token_type": tokenType,
      };
}
