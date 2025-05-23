import 'package:bluetrack/core/enum/constant_categories_enum.dart';
import 'package:bluetrack/core/enum/device_theme_mode_enum.dart';

extension ConstantCategoriesExtension on ConstantCategoriesEnum {
  int get rawValue {
    switch (this) {
      case ConstantCategoriesEnum.city:
        return 600;

      case ConstantCategoriesEnum.education:
        return 700;
      case ConstantCategoriesEnum.academy:
        return 550;
      case ConstantCategoriesEnum.userInfo:
        return 650;

      default:
        throw -1;
    }
  }
}
