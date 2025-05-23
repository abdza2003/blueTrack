import 'package:bluetrack/core/enum/image_menu_enum.dart';
import 'package:bluetrack/core/enum/service_paths_enum.dart';
import 'package:bluetrack/core/extension/image_menu_extension.dart';
import 'package:bluetrack/core/extension/service_path_extension.dart';

serverFilePath({required ImageMenuEnum fileType, required String fileName}) {
  return '${ServicePathsEnum.imagesFile.rawValue}/${fileType.rawValue}/$fileName';
}
