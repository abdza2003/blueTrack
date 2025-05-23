import 'package:bluetrack/core/enum/app_education_type_enum.dart';
import 'package:bluetrack/core/enum/app_identifier_type_enum.dart';
import 'package:bluetrack/core/enum/constant_categories_enum.dart';
import 'package:bluetrack/core/enum/device_theme_mode_enum.dart';

extension APPIdentifierTypeExtension on APPIdentifierTypeEnum {
  int get rawValue {
    switch (this) {
      case APPIdentifierTypeEnum.email:
        return 1;
      case APPIdentifierTypeEnum.phone:
        return 2;

      default:
        throw -1;
    }
  }
}
