import 'package:bluetrack/controller/device/i_device_controller.dart';
import 'package:bluetrack/core/enum/device_locale_enum.dart';
import 'package:bluetrack/core/enum/device_theme_mode_enum.dart';
import 'package:bluetrack/core/extension/device_theme_mode_extension.dart';
import 'package:bluetrack/data/sp/sp_manager.dart';
import 'package:flutter/material.dart';

class DeviceController extends IDeviceController {
  late ThemeMode themeMode = ThemeMode.system;
  late Locale? locale;
  bool notification = false;
  bool contacts = false;
  bool microphone = false;
  bool mediaAccess = false;
  bool camera = false;

  DeviceController() {
    getThemeMode();
  }

  @override
  setThemeMode(BuildContext context) {
    switch (SPManager.instance.getThemeMode()) {
      case 1:
        themeMode = ThemeMode.light;
        SPManager.instance.setThemeMode(DeviceThemeModeEnum.lightMode.rawValue);
        notifyListeners();
        break;
      case 2:
        themeMode = ThemeMode.dark;
        SPManager.instance.setThemeMode(DeviceThemeModeEnum.darkMode.rawValue);
        notifyListeners();
        break;
      default:
        var brightness = MediaQuery.of(context).platformBrightness;

        themeMode =
            (brightness == Brightness.dark) ? ThemeMode.light : ThemeMode.dark;

        SPManager.instance.setThemeMode(
          themeMode == ThemeMode.dark
              ? DeviceThemeModeEnum.darkMode.rawValue
              : DeviceThemeModeEnum.lightMode.rawValue,
        );

        notifyListeners();
        break;
    }
  }

  @override
  getThemeMode() {
    switch (SPManager.instance.getThemeMode()) {
      case 1:
        themeMode = ThemeMode.dark;
        break;
      case 2:
        themeMode = ThemeMode.light;
        break;

      default:
        themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  @override
  setLangCode(BuildContext context, DeviceLocaleEnum deviceLocaleEnum) {
    // TODO: implement setLangCode
    throw UnimplementedError();
  }
}
