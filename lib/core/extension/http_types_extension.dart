import 'package:bluetrack/core/enum/http_types_enum.dart';

extension HttpTypesExtension on HttpTypesEnum? {
  String get rawValue {
    switch (this) {
      case HttpTypesEnum.get:
        return 'GET';
      case HttpTypesEnum.getList:
        return 'GETLIST';
      case HttpTypesEnum.post:
        return 'POST';
      case HttpTypesEnum.postList:
        return 'POSTLIST';
      case HttpTypesEnum.delete:
        return 'DELETE';
      case HttpTypesEnum.put:
        return 'PUT';
      default:
        throw 'ERROR TYPE';
    }
  }
}
