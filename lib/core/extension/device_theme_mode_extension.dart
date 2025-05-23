import 'package:bluetrack/core/enum/device_theme_mode_enum.dart';

extension DeviceThemeModeExtension on DeviceThemeModeEnum {
  int get rawValue {
    switch (this) {
      case DeviceThemeModeEnum.deviceMode:
        return 0;

      case DeviceThemeModeEnum.darkMode:
        return 1;
      case DeviceThemeModeEnum.lightMode:
        return 2;

      default:
        throw -1;
    }
  }
}
