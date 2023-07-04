import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color appThemeColor = Color.fromRGBO(183, 1, 110, 1);
const Color appTextColor = Color.fromRGBO(154, 154, 154, 1);
const Color appBorderColor = Color.fromRGBO(234, 234, 234, 1);
const Color appBgColor = Color.fromRGBO(245, 245, 245, 1);
const Color appLightColor = Colors.white;
const Color appDarkColor = Colors.black;
const Color activePackageColor = Color.fromRGBO(0, 123, 175, 1);

TextStyle contentStyle = GoogleFonts.poppins(
    fontSize: 12, color: appTextColor, fontWeight: FontWeight.w300);
TextStyle activePackageColorStyle = GoogleFonts.poppins(
    fontSize: 12, color: activePackageColor, fontWeight: FontWeight.w500);
TextStyle packageContentStyle = GoogleFonts.poppins(
  fontSize: 12,
  color: appTextColor,
  fontWeight: FontWeight.w500,
  height: 2,
);

TextStyle themeTextStyle = GoogleFonts.poppins(
    fontSize: 13, color: appThemeColor, fontWeight: FontWeight.w300);

TextStyle mainHeadingStyle = GoogleFonts.poppins(
    fontSize: 20, color: appDarkColor, fontWeight: FontWeight.w600);

TextStyle headingStyle = GoogleFonts.poppins(
    fontSize: 14, color: appDarkColor, fontWeight: FontWeight.w500);

TextStyle greyHeadingStyle = GoogleFonts.poppins(
    fontSize: 14, color: appTextColor, fontWeight: FontWeight.w500);

TextStyle videoHeadingStyle = GoogleFonts.poppins(
    fontSize: 12, color: appDarkColor, fontWeight: FontWeight.w500);

TextStyle videoContentStyle = GoogleFonts.poppins(
    fontSize: 10, color: appTextColor, fontWeight: FontWeight.w400);
TextStyle smallContentStyle = GoogleFonts.poppins(
    fontSize: 9, color: appTextColor, fontWeight: FontWeight.w400);
TextStyle smallThemeColorStyle = GoogleFonts.poppins(
    fontSize: 9, color: appThemeColor, fontWeight: FontWeight.w400);

TextStyle buttonTextStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: appLightColor,
);

TextStyle textFieldInputStyle =
    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: appDarkColor);
