import 'package:flutter/material.dart';
import 'dart:ui' as ui;

extension ContextExtention on BuildContext {
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;

  double phoneHeight() => MediaQuery.of(this).size.height;
  double phoneWidth() => MediaQuery.of(this).size.width;
  bool isKeyboardVisible() => MediaQuery.of(this).viewInsets.bottom == 0.0;

  ui.TextDirection textDirection() =>
      Localizations.localeOf(this).languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr;

  ui.TextDirection textDirectionInverse() =>
      Localizations.localeOf(this).languageCode == 'ar'
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl;
  String langCode() => Localizations.localeOf(this).languageCode;
}
