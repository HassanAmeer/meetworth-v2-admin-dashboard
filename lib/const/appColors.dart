import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFFFF9EC), // Lightest shade
      100: Color(0xFFFFF3D3), // Lighter shade
      200: Color(0xFFFFE8CD), // Light
      300: Color(0xFFFFE0B3), // Slightly lighter than base
      400: Color(0xFFFFD29B), // Base color with more vibrance
      500: Color(_primaryValue), // Base color (#f2e58e)
      600: Color(0xFFFFC67D), // Slightly darker
      700: Color(0xFFFFB55C), // Darker shade
      800: Color(0xFFFFA147), // Darker shade
      900: Color(0xFFF7893D), // Darkest shade
    },
  );

  static const int _primaryValue = 0xFFf2e58e;
  static Color primaryDark = const Color(0xffB3A441);
  static Color primaryMid = const Color(0xffE6B863);

  static const gold = Color(0xffC0822D);
  static const silverGold = Color(0xff7C7161);

  static const iconLight = Colors.white;
  static const iconSilver = Color.fromARGB(255, 229, 229, 229);
  static const textLight = Colors.white;
  static const textSilver = Color.fromARGB(255, 192, 192, 192);
  static const textSilverDark = Color.fromARGB(255, 127, 127, 127);
  static const textGreen = Colors.green;
  static const textRed = Colors.red;
  static const textGold = Color(0xffE6B863);
  static const bgColor = Color(0xff121212);
  static const transparenCardBlack = Colors.black45;
  static const bgField = Color(0xff4A4A4A);
  static Color btnColor = Color(0xFF00192D);
  static const bgCard = Color.fromARGB(255, 36, 36, 36);
  static Color bgCard2 =
      const Color.fromARGB(255, 101, 96, 96).withOpacity(0.4);
  static Color sideBarBgColor =
      const Color.fromARGB(255, 101, 96, 96).withOpacity(0.4);
  static Color blackOp4 = Colors.black.withOpacity(0.4);

  // pieChartColor
  static const pieChartColor1 = Color(0xffB2B2B2);
  static const pieChartColor2 = Color(0xff9A5933);
}
