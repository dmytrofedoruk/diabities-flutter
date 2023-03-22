import 'package:flutter/material.dart';

class StyleConstants {
  static const List<BoxShadow> initShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      offset: Offset(0, -5),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> secondaryShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      offset: Offset(0, 0),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> thirdShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      offset: Offset(0, 5),
      blurRadius: 15,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> forthShadow = [
    BoxShadow(
      color: Color.fromRGBO(0, 95, 255, 0.15),
      offset: Offset(0, 9),
      blurRadius: 9,
      spreadRadius: 0,
    ),
  ];
}
