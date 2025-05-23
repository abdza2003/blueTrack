import 'package:bluetrack/core/enum/profile_edit_type_enum.dart';

extension ProfileEditTypeExtension on ProfileEditTypeEnum {
  int get rawValue {
    switch (this) {
      case ProfileEditTypeEnum.work:
        return 10;

      case ProfileEditTypeEnum.bio:
        return 20;

      case ProfileEditTypeEnum.color:
        return 30;

      case ProfileEditTypeEnum.city:
        return 40;

      case ProfileEditTypeEnum.fullName:
        return 50;

      case ProfileEditTypeEnum.phoneNumber:
        return 60;

      case ProfileEditTypeEnum.email:
        return 70;

      case ProfileEditTypeEnum.dateOfBirth:
        return 80;

      case ProfileEditTypeEnum.gender:
        return 90;

      case ProfileEditTypeEnum.userName:
        return 100;

      case ProfileEditTypeEnum.generalInfo:
        return 110;

      case ProfileEditTypeEnum.coverPicture:
        return 120;

      case ProfileEditTypeEnum.picture:
        return 130;

      case ProfileEditTypeEnum.education:
        return 140;

      case ProfileEditTypeEnum.academy:
        return 150;

      default:
        throw -1;
    }
  }
}
