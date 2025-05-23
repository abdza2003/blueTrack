import 'package:bluetrack/core/enum/font_family_enum.dart';

extension FontFamilyExtansion on FontFamilyEnum {
  String get rawValue {
    switch (this) {
      case FontFamilyEnum.ar:
        return 'Almarai';
      case FontFamilyEnum.en:
        return 'Poppins';
      case FontFamilyEnum.enInter:
        return 'Inter';
      case FontFamilyEnum.enSora:
        return 'Sora';

      default:
        throw 'ERROR TYPE';
    }
  }
}
