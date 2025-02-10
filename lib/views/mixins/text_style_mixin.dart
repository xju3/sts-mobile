import 'package:flutter/material.dart';

mixin TextStyleMixin {
  static const double fontSizeSmall = 12.0;
  static const double fontSizeNormal = 14.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeExtraLarge = 20.0;

  static const Color colorPrimary = Colors.blue;
  static const Color colorSecondary = Colors.grey;
  static const Color colorSuccess = Colors.green;
  static const Color colorError = Colors.red;
  static const Color colorWarning = Colors.orange;
  static const Color colorInfo = Colors.lightBlue;
  static const Color colorTextPrimary = Colors.black87;
  static const Color colorTextSecondary = Colors.black54;
  static const Color colorTextDisabled = Colors.black38;
  static const Color colorBorder = Colors.black12;

  TextStyle textstyleSma({Color? color}) =>
      TextStyle(
        fontSize: fontSizeSmall,
        color: color ?? colorTextSecondary,
      );

  TextStyle textstyleNor({Color? color}) =>
      TextStyle(
        fontSize: fontSizeNormal,
        color: color ?? colorTextPrimary,
      );

  TextStyle textstyleMed({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: fontSizeMedium,
        color: color ?? colorTextPrimary,
        fontWeight: fontWeight,
      );

  TextStyle textstyleLar({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: fontSizeLarge,
        color: color ?? colorTextPrimary,
        fontWeight: fontWeight,
      );

  TextStyle textstyleExLar({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: fontSizeExtraLarge,
        color: color ?? colorTextPrimary,
        fontWeight: fontWeight,
      );
}
