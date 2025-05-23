import 'package:bluetrack/core/enum/constant_categories_enum.dart';
import 'package:bluetrack/core/enum/device_theme_mode_enum.dart';
import 'package:bluetrack/core/enum/general_status_enum.dart';

extension GeneralStatusExtension on GeneralStatusEnum {
  int get rawValue {
    switch (this) {
      case GeneralStatusEnum.opened:
        return 1;

      case GeneralStatusEnum.closed:
        return 0;
      case GeneralStatusEnum.public:
        return 100;
      case GeneralStatusEnum.private:
        return 103;
      case GeneralStatusEnum.friend:
        return 101;

      default:
        throw -1;
    }
  }
}
