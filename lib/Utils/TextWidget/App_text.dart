import 'package:flutter/material.dart';
import 'package:orioconnect/Utils/ScreenSize/screen_size_utils.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const AppText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        decoration: decoration, // Underline support
      ),
    );
  }
}

class AppTextStyle {
  static Widget title({
    required BuildContext context,
    required String text,
    Color? color,
    TextAlign? textAlign,
    TextDecoration? decoration, 
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: context.responsiveWidth(0.06),
        fontWeight: FontWeight.w400,
        color: color,
        decoration: decoration,
      ),
    );
  }

  static Widget subtitle({
    required BuildContext context,
    required String text,
    Color? color,
    TextAlign? textAlign,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: context.responsiveWidth(0.035),
        fontWeight: FontWeight.w300,
        color: color,
        decoration: decoration,
      ),
    );
  }

  static Widget body({
    required BuildContext context,
    required String text,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: context.responsiveWidth(0.035),
        fontWeight: FontWeight.normal,
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        decoration: decoration,
      ),
    );
  }

  static Widget small({
    required BuildContext context,
    required String text,
    Color? color,
    TextAlign? textAlign,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: context.responsiveWidth(0.03),
        fontWeight: FontWeight.normal,
        color: color ?? Theme.of(context).textTheme.bodySmall?.color,
        decoration: decoration,
      ),
    );
  }

  static Widget custom({
    required BuildContext context,
    required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextDecoration? decoration, 
  }) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        decoration: decoration
      ),
    );
  }
}
