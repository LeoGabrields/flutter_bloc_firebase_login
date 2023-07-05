import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();
  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get fontFamily => 'Poppins';

  TextStyle get textRegular => TextStyle(
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
      color: const Color(0xFF615F5F));
  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.w700, fontFamily: fontFamily);

  TextStyle get textTitle => textBold.copyWith(fontSize: 25);
  TextStyle get textButton => textRegular.copyWith(fontSize: 14);
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
