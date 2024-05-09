import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  //brand colors
  static const primaryDark = Color(0xffFA7600);
  static const primaryLight = Color(0xffFA7600);

  static const secondaryDark = Color(0xff363636);
  static const secondaryLight = Color(0xffffffff);

  static const tertiaryDark = Color(0xff39d2c0);
  static const tertiaryLight = Color(0xff39d2c0);

  static const alertnateDark = Color(0xff39d2c0);
  static const alertnateLight = Color(0xff39d2c0);

  // utility colors
  static const primaryTextDark = Color(0xffffffff);
  static const primaryTextLight = Color(0xff000000);

  static const secondaryTextDark = Color.fromARGB(255, 162, 149, 149);
  static const secondaryTextLight = Color.fromARGB(255, 55, 57, 57);

  static const primaryBackgroundDark = Color.fromARGB(255, 39, 40, 40);
  static const primaryBackgroundLight = Color.fromARGB(255, 227, 236, 235);

  static const secondaryBackgroundDark = Color.fromARGB(255, 57, 63, 191);
  static const secondaryBackgroundLight = Color(0xff39d2c0);

  //accent colors
  static const accent1Dark = Color(0x4c4b39ef);
  static const accent1Light = Color(0x4c4b39ef);

  static const accent2Dark = Color(0x4d39d2c0);
  static const accent2Light = Color(0x4d39d2c0);

  static const accent3Dark = Color(0x4dee8b60);
  static const accent3Light = Color(0x4dee8b60);

  static const accent4Dark = Color(0xccffffff);
  static const accent4Light = Color(0xccffffff);

  //sementic colors

  static const successDark = Color(0xff249689);
  static const successLight = Color(0xff249689);

  static const errorDark = Color(0xffff5963);
  static const errorLight = Color(0xffff5963);

  static const warningDark = Color(0xff19cf58);
  static const warningLight = Color(0xff19cf58);

  static const infoDark = Color(0xffffffff);
  static const infoLight = Color(0xffffffff);

  //other colors
  static const white = Color(0xffffffff);
  static const transparent = Colors.transparent;
  static const black = Color(0xff000000);
}

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
