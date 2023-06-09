import 'package:flutter/material.dart';

class ColorTheme {
  final Color primaryColor;
  final Color primaryColorDark;
  final Color primaryColorLight;
  final Color scaffoldBackgroundColor;
  final Color dividerColor;
  final Color cardColor;
  final Color canvasColor;
  final Color textColor;
  final Color textSecondaryColor;
  final Color textThirdColor;
  final Color surfaceColor;
  final Color errorColor;
  final Color snackBarBackgroundColor;
  final Color snackBarColor;
  final Color cursorColor;
  final Color inputFocusBorderColor;
  final Color bottomSheetBackgroundColor;
  final Color bottomSheetModalBackgroundColor;
  final Color textButtonDisableColor;
  final Color textButtonDisableTextColor;
  final Color elevatedButtonDisableColor;
  final Color elevatedButtonDisableTextColor;
  final Color outlinedButtonDisableColor;
  final Color outlinedButtonDisableTextColor;

  ColorTheme({
    required this.primaryColor,
    required this.primaryColorDark,
    required this.primaryColorLight,
    required this.scaffoldBackgroundColor,
    required this.dividerColor,
    required this.cardColor,
    required this.canvasColor,
    required this.textColor,
    required this.textSecondaryColor,
    required this.textThirdColor,
    required this.surfaceColor,
    required this.errorColor,
    required this.snackBarBackgroundColor,
    required this.snackBarColor,
    required this.cursorColor,
    required this.inputFocusBorderColor,
    required this.bottomSheetBackgroundColor,
    required this.bottomSheetModalBackgroundColor,
    required this.textButtonDisableColor,
    required this.textButtonDisableTextColor,
    required this.elevatedButtonDisableColor,
    required this.elevatedButtonDisableTextColor,
    required this.outlinedButtonDisableColor,
    required this.outlinedButtonDisableTextColor,
  });
}

ColorTheme colorThemeLight = ColorTheme(
  //primaryColor: const Color(0xFF0B69FF),
  primaryColor: Colors.white,

  primaryColorDark: Colors.white,
  primaryColorLight: const Color(0xFF56CCF2),
  scaffoldBackgroundColor: HexColor.fromHex("#F5F5F5"),
  dividerColor: const Color.fromRGBO(142, 142, 147, 0.8),
  cardColor: Colors.white,
  canvasColor: const Color.fromRGBO(245, 245, 245, 0),
  textColor: Colors.white,
  textSecondaryColor: Colors.white,
  textThirdColor: const Color(0xFFBDBDBD),
  surfaceColor: const Color(0xFFF2F2F2),
  errorColor: const Color(0xFFFA1616),
  snackBarBackgroundColor: const Color(0xFF1D2338),
  snackBarColor: Colors.white,
  cursorColor: Colors.white,
  inputFocusBorderColor: Colors.white,
  bottomSheetBackgroundColor: Colors.white,
  bottomSheetModalBackgroundColor: Colors.white,
  textButtonDisableColor: const Color(0xFFE9E9E9),
  textButtonDisableTextColor: const Color(0xFFBDBDBD),
  elevatedButtonDisableColor: const Color(0xFFE9E9E9),
  elevatedButtonDisableTextColor: const Color(0xFFBDBDBD),
  outlinedButtonDisableColor: const Color(0xFFBDBDBD),
  outlinedButtonDisableTextColor: const Color(0xFFBDBDBD),
);

ColorTheme colorThemeDark = ColorTheme(
  //primaryColor: const Color(0xFF0B69FF),
  primaryColor: const Color(0x00000000),
  primaryColorDark: Color.fromARGB(255, 255, 255, 255),
  primaryColorLight: const Color(0xFF56CCF2),
  scaffoldBackgroundColor: const Color(0xFF18191A),
  dividerColor: const Color.fromRGBO(173, 181, 189, 0.2),
  cardColor: const Color(0xFF242526),
  canvasColor: const Color(0xFF3A3B3C),
  textColor: const Color(0xFFE1E3E8),
  textSecondaryColor: const Color(0xFFB0B3B8),
  textThirdColor: const Color(0xFFB0B3B8),
  surfaceColor: const Color(0xFF242526),
  errorColor: const Color(0xFFFA1616),
  snackBarBackgroundColor: const Color(0xFF1D2338),
  snackBarColor: const Color(0xFFE1E3E8),
  cursorColor: const Color(0xFFE1E3E8),
  inputFocusBorderColor: const Color(0xFF0B69FF),
  bottomSheetBackgroundColor: const Color(0xFF242526),
  bottomSheetModalBackgroundColor: const Color(0xFF3A3B3C),
  textButtonDisableColor: const Color(0xFFE9E9E9),
  textButtonDisableTextColor: const Color(0xFFBDBDBD),
  elevatedButtonDisableColor: const Color(0xFFE9E9E9),
  elevatedButtonDisableTextColor: const Color(0xFFBDBDBD),
  outlinedButtonDisableColor: const Color(0xFFBDBDBD),
  outlinedButtonDisableTextColor: const Color(0xFFBDBDBD),
);

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
