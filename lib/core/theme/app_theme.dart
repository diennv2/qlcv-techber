import 'package:flutter/material.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/core/values/font_family.dart';

final ThemeData themeData = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: FontFamily.fontRegular,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: AppColors.Primary,
  primaryColorDark: AppColors.PrimaryDark,
);

final ThemeData themeDataDark = ThemeData(
  primarySwatch: Colors.blueGrey,
  fontFamily: FontFamily.fontRegular,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
