import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practical_test/app/config/app_colors.dart';

TextStyle textSemiBold({
  double? fontSize = 10,
  Color? fontColor,
}) {
  return GoogleFonts.titilliumWeb(
    color: fontColor ?? APPCOLOR.BlACKCOLOR,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
  );
}

TextStyle textBold({
  double? fontSize = 10,
  Color? fontColor,
}) {
  return GoogleFonts.titilliumWeb(
    color: fontColor ?? APPCOLOR.BlACKCOLOR,
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
  );
}

TextStyle textNormal({
  double? fontSize = 10,
  Color? fontColor,
}) {
  return GoogleFonts.titilliumWeb(
    color: fontColor ?? APPCOLOR.BlACKCOLOR,
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
  );
}

TextStyle textMedium({
  double? fontSize = 10,
  Color? fontColor,
}) {
  return GoogleFonts.titilliumWeb(
    color: fontColor ?? APPCOLOR.BlACKCOLOR,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
  );
}
