import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorResources {
  static const appMainColor = Color(0xff0074FC);
  static const whiteColor = Color(0xffFFFFFF);
  static const blackColor = Color(0xff000000);
  static const greyColor = Color(0xffF4F4F4);
  static const textfeildColor = Color(0xffE0E0E0);
  static const backgroundWhiteColor = Color(0xffF9FAFB);
  static const secondryColor = Color(0xff001E31);
  static const hintTextColor = Color(0xff1A1C1E);
  static const blueColor = Color(0xff1565FF);
  static const containerColor = Color(0xffF3F2F2);
  static const textBlueColor = Color(0xff000C19);
  static const floatingbuttonColor = Color(0xff001E31);
  static const lightBlueColor = Color(0xffE6F1FF);
  static const gradientRed = Color(0xFFBA0C2F);

  static SystemUiOverlayStyle getSystemUiOverlayStyle() {
    return SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: whiteColor,
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }
}
