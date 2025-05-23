import 'package:bluetrack/core/enum/service_paths_enum.dart';
import 'package:bluetrack/core/extension/service_path_extension.dart';
import 'package:bluetrack/data/sp/sp_manager.dart';

class UserContext {
  // static bool userIsLogin() {
  //  String? token = SPManager.instance.getAccessToken();
  //   if(token == null || token == ''){
  //     return false;
  //   }else{
  //     return true;
  //   }
  // }

  //static String activeUrl = ServicePathsEnum.localUrl.rawValue;

  static String activeUrl = ServicePathsEnum.debugUrl.rawValue;
}
