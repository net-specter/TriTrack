import 'package:flutter/material.dart';

class TriColors {
  static Color primary = const Color(0xFF4E61F6);
  static Color secondary = const Color(0xFFEE443F);
  static Color success = const Color(0xFF43B75D);
  static Color warning = const Color(0xFFFFAA00);

  // ignore: deprecated_member_use
  static Color primaryLight = const Color(0xFF4E61F6).withOpacity(0.5);
  // ignore: deprecated_member_use
  static Color secondaryLight = const Color(0xFFEE443F).withOpacity(0.5);

  static Color backgroundAccent = const Color(0xFFEDEDED);

  static Color gold = const Color(0xFFCEAD00);
  static Color silver = const Color(0xFF888888);
  static Color brown = const Color(0xFFA52A2A);
  static Color lightGray = const Color(0xFFF3F4F6);
  static Color steelBlue = const Color(0xFF9DB2CE);

  static Color greyLight = const Color(0xFFE2E2E2);
  static Color greyDark = const Color(0xFF7D7D7D);

  static Color white = Colors.white;

  static Color get backGroundColor {
    return TriColors.primary;
  }

  static Color get textLabel {
    return TriColors.greyDark;
  }

  static Color get disabled {
    return TriColors.greyLight;
  }
}
