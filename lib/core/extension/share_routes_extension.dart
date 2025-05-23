import 'package:bluetrack/core/enum/app_education_type_enum.dart';
import 'package:bluetrack/core/enum/constant_categories_enum.dart';
import 'package:bluetrack/core/enum/device_theme_mode_enum.dart';
import 'package:bluetrack/core/enum/share_routes_enum.dart';

extension ShareRoutesExtension on ShareRoutesEnum {
  String get rawValue {
    switch (this) {
      case ShareRoutesEnum.product:
        return 'product';
      case ShareRoutesEnum.vendor:
        return 'store';

      default:
        throw -1;
    }
  }
}
