import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#2675EC");
  static Color accent = HexColor.fromHex("#4C5FA5");
  static Color red = HexColor.fromHex("#CF0000");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#C7C7CC");
  static Color cardColor = HexColor.fromHex("#F9F9F9");
  static Color primaryOpacity70 = HexColor.fromHex("#2675EC");
  static Color fontColor = HexColor.fromHex("#4D4D4D");
  static Color shadowColor = HexColor.fromHex("#545596").withOpacity(0.2);
  static Color yellow = HexColor.fromHex("#FFCB53");
  static Color lightYellow = HexColor.fromHex("#FFF6DB");
  static Color textFieldColor = HexColor.fromHex('#000000').withOpacity(0.08);

  // new colors
  static Color black = HexColor.fromHex("#000000");
  static Color blue = HexColor.fromHex("#00BEE8");
  static Color grey2 = HexColor.fromHex("#F6F6F6");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color transparent = Colors.transparent;
  static Color error = HexColor.fromHex("#E94125");
  static Color grey3 = HexColor.fromHex('#606060');
  static Color grey4 = HexColor.fromHex('#FAFAFA');
  static Color grey5 = HexColor.fromHex('#AAAAAA');
  static Color grey6 = HexColor.fromHex('#F6F6F6');
  static Color blueAccent = HexColor.fromHex('#CBF6FF');
  static Color pinkAccent = HexColor.fromHex('#FEE4E4');
  static Color redAccent = HexColor.fromHex('#F77777');
  static Color greenAccent = HexColor.fromHex('#EBF8EE');
  static Color green = HexColor.fromHex('#00A52C');
  static Color gold = HexColor.fromHex('#FFF6DB');
  static Color orangeAccent = HexColor.fromHex('#FFEBDF');
  static Color navy = HexColor.fromHex('#000080');

  // Dark Theme
  static Color scaffoldDarkColor = HexColor.fromHex("#16202A");
  static Color darkAccent = HexColor.fromHex("#080D11");
  static Color darkPrimary = HexColor.fromHex("#FFBA50");
  static Color darkShadowColor = HexColor.fromHex("#1F1F1F");
  static Color cardDarkColor = HexColor.fromHex("#1F1F1F");

  // List Colors:
  static Color lightGreen = HexColor.fromHex("#1ecdc4");
  static Color textColor = HexColor.fromHex("#0c1430");
  static Color lightBlue = HexColor.fromHex("#7eccff");
  static Color darkOrange = HexColor.fromHex("#ffa348");
  static Color pink = HexColor.fromHex("#ffa6c4");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
