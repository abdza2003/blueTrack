import 'package:flutter/material.dart';

class GlobalVariablesManager {
  static final GlobalVariablesManager instance =
      GlobalVariablesManager._internal();

  GlobalVariablesManager._internal();

  final String userToken = 'user_token';
  final String appSecurityKey = 'circleMobilV100';
  final String userName = 'user_name';
  final String userId = 'user_id';
  final String oneSignalID = '';
  final String unKey = 'user_name';
  final String pwKey = 'user_password';
  final String tenantIdKey = 'tenant_id';
  final int dbVersion = 2;
  final String allUserInfo = 'all_user_info';
  final String resturantId = 'resturant_id';
  final String menuid = 'menu_id';
  final String resturantAndMenuName = 'resturant_menu_name';
  final String fetchMenuAndResturant = 'fetch_menu_resturant';
  final int konyaIliCode = 21220;
  final String bottomNavScreen = 'bottom_nav_screen';

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
