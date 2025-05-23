import 'package:bluetrack/core/enum/modified_data_enum.dart';

extension ModifiedDataExtension on ModifiedDataEnum {
  int get rawValue {
    switch (this) {
      case ModifiedDataEnum.localization:
        return 1;
      case ModifiedDataEnum.userInfo:
        return 2;
      case ModifiedDataEnum.appInfo:
        return 3;
      case ModifiedDataEnum.myLastPost:
        return 4;

      default:
        throw 'ERROR TYPE';
    }
  }
}
