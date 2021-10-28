import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static const primaryColor = Color(0xFFF9875A);
  static const secondaryColor = Color(0xFFFFAD40);
  static const tertiaryColor = Color(0xFFE5E5E5);
  static const quaternaryColor = Color(0xFFBCBCBC);
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF0C7DA7);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static TextStyle text1 = GoogleFonts.poppins(
      color: AppTheme.primaryColor,
      fontSize: 24,
      fontWeight: FontWeight.w800);
  static TextStyle text2 = GoogleFonts.poppins(
      color: AppTheme.secondaryColor,
      fontSize: 36,
      fontWeight: FontWeight.bold);

  static TextStyle text3 = GoogleFonts.poppins(
      color: AppTheme.secondaryColor,
      fontSize: 24,
      fontWeight: FontWeight.bold);

  static TextStyle text4 = GoogleFonts.poppins(
      color: AppTheme.primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);

  static TextStyle text5 = GoogleFonts.poppins(
      color: AppTheme.secondaryColor,
      fontSize: 30,
      //fontWeight: FontWeight.bold,
      height: 0.9,
      wordSpacing: 1,
      letterSpacing: 1);
  static TextStyle text6 = GoogleFonts.poppins(
    color: AppTheme.tertiaryColor,
    fontSize: 12,
    //fontWeight: FontWeight.bold,
    //decoration: TextDecoration.underline
  );
  static TextStyle text7 = GoogleFonts.poppins(
      color: AppTheme.primaryColor,
      fontSize: 12,
      fontWeight: FontWeight.w500);

  static TextStyle text8 = GoogleFonts.poppins(
      color: AppTheme.tertiaryColor,
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static TextStyle text9 = GoogleFonts.poppins(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle text10 = GoogleFonts.poppins(
      color: AppTheme.primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.w500);
  static TextStyle text11 = GoogleFonts.poppins(
      color: AppTheme.tertiaryColor,
      fontSize: 16,
      fontWeight: FontWeight.normal);
  static TextStyle text12 = GoogleFonts.poppins(
      color: AppTheme.tertiaryColor,
      fontSize: 14,
      fontWeight: FontWeight.bold);
  static TextStyle text13 = GoogleFonts.poppins(
      color: AppTheme.nearlyBlue,
      fontSize: 14,
      fontWeight: FontWeight.normal);
  static TextStyle text14 = GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 10,
      fontWeight: FontWeight.normal);
  static TextStyle text15 = GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.bold);
  static TextStyle text16 = GoogleFonts.poppins(
      color: Colors.grey,
      fontSize: 28,
      fontWeight: FontWeight.bold);

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const List<Color> primarylinearGradiant = [Color(0xFFFFFFFF),Color(0xFFE6E6E6)];
  static const List<Color> secondarylinearGradiant = [Color(0xFF00AAFF),Color(0xFF2849F0)];
}
