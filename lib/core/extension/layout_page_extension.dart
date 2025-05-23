import 'package:bluetrack/core/enum/image_menu_enum.dart';
import 'package:bluetrack/core/enum/layout_page_enum.dart';

extension LayoutPagesExtension on LayoutPagesEnum {
  int get rawValue {
    switch (this) {
      case LayoutPagesEnum.home:
        return 0;
      case LayoutPagesEnum.bluetrack:
        return 1;
      case LayoutPagesEnum.dashboard:
        return 2;
      case LayoutPagesEnum.profile:
        return 3;

      default:
        throw 'ERROR TYPE';
    }
  }
}
