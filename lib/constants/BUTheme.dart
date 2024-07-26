import 'package:bandu/constants/ColorsConst.dart';
import 'package:bandu/ext/sizes_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BUTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorsConst.PRIMARY,
    primaryColorDark: ColorsConst.PRIMARY_DARK,
    fontFamily: GoogleFonts.inriaSans().fontFamily,
    primaryColorLight: ColorsConst.PRIMARY,
    highlightColor: ColorsConst.SECONDARY,
    hoverColor: ColorsConst.SECONDARY,

    scaffoldBackgroundColor: ColorsConst.WHITE,
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(ColorsConst.PRIMARY),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            color: ColorsConst.WHITE,
            fontSize: 16,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            color: ColorsConst.PRIMARY,
            fontSize: 16,
          ),
        ),
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 5.pW,
        fontWeight: FontWeight.w500,
      ),
     bodyMedium: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 4.pW,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 3.5.pW,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 3.5.pW,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 4.pW,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 5.pW,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 6.pW,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 5.pW,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        color: ColorsConst.BLACK,
        fontSize: 4.pW,
        fontWeight: FontWeight.w500,
      ),

    ),

    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ButtonStyle(

        shadowColor: WidgetStateProperty.all<Color>(ColorsConst.PRIMARY),
        backgroundColor: WidgetStateProperty.all<Color>(ColorsConst.PRIMARY),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            color: ColorsConst.WHITE,
            fontSize: 16,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorsConst.WHITE_SHADOW,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsConst.PRIMARY,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsConst.WHITE_SHADOW,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsConst.WHITE_SHADOW,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
