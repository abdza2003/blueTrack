import 'package:bluetrack/core/enum/image_menu_enum.dart';

extension ImageMenuExtenction on ImageMenuEnum {
  String get rawValue {
    switch (this) {
      case ImageMenuEnum.image:
        return 'assets/images';
      case ImageMenuEnum.icon:
        return 'assets/icons';
      case ImageMenuEnum.lottie:
        return 'assets/lottie';
      case ImageMenuEnum.svg:
        return 'assets/svg';
      case ImageMenuEnum.rive:
        return 'assets/rive';
      case ImageMenuEnum.launcher:
        return 'assets/launcher';
      case ImageMenuEnum.pictureUser:
        return 'picture_user';
      case ImageMenuEnum.cover:
        return 'cover';

      default:
        throw 'ERROR TYPE';
    }
  }
}
