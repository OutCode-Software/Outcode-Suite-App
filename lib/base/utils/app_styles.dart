import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyles {
  AppStyles._();

  static TextStyle general(
          {Color color = AppColors.secondaryTextDark,
          double size = 16,
          FontWeight fontweight = FontWeight.w900}) =>
      TextStyle(fontSize: size, color: color, fontWeight: fontweight);
  //////////////////////////////////////////////////////////////////////////////////////////

  /// ALl bold styles

  static TextStyle boldExtraLarge({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldLarge({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldMedium({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldRegular({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldSmall({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w700);
  static TextStyle boldExtraSmall({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w700);
  /////////////////////////////////////////////////////////////////////////////////////////

  ///All regular styles
  static TextStyle regularExtraLarge(
          {Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularLarge({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularMedium({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularSmall({Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w400);
  static TextStyle regularExtraSmall(
          {Color color = AppColors.primaryTextDark}) =>
      TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w400);

  //////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle caption(
          {Color color = AppColors.primaryTextDark,
          double size = 10,
          FontWeight weight = FontWeight.w500}) =>
      TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      );

  //////////////////////////////////////////////////////////////////////////////////////////

  // All text field styles
  static TextStyle placeholder({Color color = AppColors.secondaryTextDark}) =>
      TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: FontWeight.w400,
      );

  static TextStyle textFieldTextStyle(
          {Color color = AppColors.secondaryTextDark}) =>
      TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.w500);

  static OutlineInputBorder outlinedInputBorder(
          {bool hasValidationError = false,
          Color borderColor = AppColors.transparent,
          double borderRadius = 16.0}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
            width: hasValidationError ? 1.0 : 1.0,
            color: hasValidationError ? AppColors.errorDark : borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      );

  //////////////////////////////////////////////////////////////////////////////////////////

  /// All button Styles
  static TextStyle buttonWhiteTextSmall(Color color,
          {double fontSize = 16.0, bool hasUnderline = false}) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          decoration:
              hasUnderline ? TextDecoration.underline : TextDecoration.none);

  //////////////////////////////////////////////////////////////////////////////////////////
  ///
  static OutlineInputBorder textViewBorder() => OutlineInputBorder(
        borderSide: const BorderSide(width: 0, color: AppColors.transparent),
        borderRadius: BorderRadius.circular(0),
      );

  static BoxDecoration bottomSheetBoxDecoration() => BoxDecoration(
      color: AppColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(1, -1), // changes position of shadow
        )
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));
}
