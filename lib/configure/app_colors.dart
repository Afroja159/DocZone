import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primaryColor       = Colors.redAccent;
  // static const primaryColor       = Color(0xFF03221d);
  static const secondaryColor     = Colors.redAccent;
  // static const secondaryColor     = Color(0xff388e3c);
  static const lightGreen         = Color(0xFFc8e6c9);
  static const backgroundColor    = Colors.white;
  static const black              = Colors.black;
  static const primaryFontColor   = Color(0xff4a4b4d);
  static const secondaryFontColor = Color(0xff7c7d7e);
  static const greenColor         = Color(0xff4BFF5D);
  static const green              = Colors.green;
  static const color1             = Color(0xFFf6e58d);
  static const color2             = Color(0xFFFB0150);
  static const color3             = Color(0xFFDB13A2);
  static const color4             = Color(0xFF8E1B9E);
  static const deepBlue           = Color(0xFF130f40);
  static const lightBlue          = Color(0xFF3B3B98);
  static const color5             = Color(0xffffe7c4);
  static const iconColor          = Color(0xFF18181B);
  static const buttonColor        = Color(0xffda3f81);
  static const appBarColor        = Color(0xFF03221d);
  static const appBarPrimary      = Color(0xFFDB13A2);
  static const redColor           = Colors.redAccent;
  static const greyColor          = Colors.grey;
  static const textColor          = Colors.white;
  static const secondaryTextColor = Colors.black;
  static const lightWhite         = Colors.white70;
  static const lightBlack         = Colors.black38;
  static const grayLight          = Color(0xff8b97a2);
  static final gradientColor      = [
    const Color(0xFF11998e),
    const Color(0xFF38ef7d),
  ];
  static final gradientColorSplash = [
    const Color(0xFF11998e),
    const Color(0xFF38ef7d),
  ];
  static final gradientColor1 = [
    const Color(0xff6a00f4),
    const Color(0xffbc00dd),
    const Color(0xff8900f2),
  ];
  static final gradientColor2 = [
    lightWhite,
    color4.withOpacity(0.5),
    lightWhite,
  ];
}

class AppStyle {
  static final titleText = GoogleFonts.lobsterTwo(textStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: AppColors.primaryFontColor));
  static const timingText = TextStyle(color: Colors.black54);
  static const appTitle = 'On The Way Queen';
  static const checkOutStyle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 15);
  static const checkOutTextStyle =
      TextStyle(fontWeight: FontWeight.w300, fontSize: 16);
  static const title1 = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 28, color: AppColors.secondaryTextColor);
  static const title2 = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 23, color: AppColors.textColor);
  static const title3 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.primaryFontColor);
  static const title4 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.primaryFontColor);
  static const title5 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 27, color: AppColors.primaryFontColor);
  static const titleList = TextStyle(
      fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.textColor, height: 2, letterSpacing: 3);
  static const splashTitle = TextStyle(
      fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.iconColor, height: 2, letterSpacing: 3);
  static const title3black = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 22, color: AppColors.primaryColor);
  static const title3Override = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.primaryFontColor);
  static final title1Override = TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 28,
      color: Colors.white.withOpacity(0.8));
  static const bodyText1 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.black);
  static const tagText = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.black);
  static const bodyText1Override = TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 14,
      color: AppColors.textColor,
      letterSpacing: 1);

  static var backgroundStyle = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: AppColors.gradientColor,
    ),
  );
}

class AppSize {
  static const borderRadiusSize = 8.00;
}
