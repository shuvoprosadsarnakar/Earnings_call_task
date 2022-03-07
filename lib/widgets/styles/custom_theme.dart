import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/styles/color_pallate.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
          fontFamily: 'Sarabun',
          brightness: Brightness.light,
          primaryColor: ColorPallate.limeGreen,
          canvasColor: Colors.white
    );
  }
}