import 'package:bluetrack/core/components/hex_color.dart';
import 'package:bluetrack/core/constants/color_constant.dart';
import 'package:bluetrack/core/extension/color_extansion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData buildThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      // scaffoldBackgroundColor: ColorConstants.instance.lightModeBackground,
      scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
      primaryColor: ColorConstants.instance.primary,
      platform: TargetPlatform.iOS,

      colorScheme: ColorScheme.light(
        primary: ColorConstants.instance.primary,
        // background: ColorConstants.instance.lightModeBackground,
        surface: CupertinoColors.extraLightBackgroundGray,
        secondary: Colors.white,

        //لون البوردر
        onSecondary: ColorConstants.instance.black.withOpacity(.24),
        // اللون العكسي للمود
        onSurface: Colors.black,
      ),
      appBarTheme: AppBarTheme(color: ColorConstants.instance.primary),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(ColorConstants.instance.primary),
      ),
    );
  }

  ThemeData buildThemeDataDark(BuildContext context) {
    return ThemeData(
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(ColorConstants.instance.primary),
      ),
      useMaterial3: false,
      platform: TargetPlatform.iOS,
      scaffoldBackgroundColor: HexColor('#28282a'),
      primaryColor: ColorConstants.instance.primary,
      brightness: Brightness.dark,
      cardColor: const Color.fromARGB(255, 30, 30, 30),
      colorScheme: ColorScheme.dark(
        primary: ColorConstants.instance.primary,
        surface: HexColor('#28282a'),
        secondary: HexColor('#18181a'),
        onSecondary: ColorConstants.instance.white.withOpacity(.24),
        onSurface: Colors.white,
      ),
      appBarTheme: AppBarTheme(color: ColorConstants.instance.primary),
    );
  }
}
