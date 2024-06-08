import 'package:flutter/material.dart';
import 'package:shoppingcart/utils/gen/gen.dart';

class AppStyle {
  static const double _fontSizeScale = 0;

  static TextStyle bold([double fontSize = 16]) {
    fontSize += _fontSizeScale;
    return TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: ColorName.text,
        height: 1);
  }

  static TextStyle medium([double fontSize = 16]) {
    fontSize += _fontSizeScale;
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: ColorName.text,
        height: 1);
  }

  static TextStyle regular([double fontSize = 16]) {
    fontSize += _fontSizeScale;
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: ColorName.text,
        height: 1);
  }
}
