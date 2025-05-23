import 'package:bluetrack/core/enum/sp_manager_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPManager {
  late SharedPreferences prefs;

  static SPManager? _instace;

  static SPManager get instance {
    if (_instace != null) return _instace!;
    _instace = SPManager._init();
    return _instace!;
  }

  SPManager._init() {
    startingCache();
  }

  startingCache() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? getTranslationDate() {
    return prefs.getString(SPManagerEnum.translationDate.toString()) ?? "";
  }

  bool? getSkipLoginStatus() {
    return prefs.getBool(SPManagerEnum.skipLoginStatus.toString());
  }

  Future<bool>? setSkipLoginStatus() async {
    return await prefs.setBool(SPManagerEnum.skipLoginStatus.toString(), true);
  }

  String? getUserFavoriteLastUpdateDate() {
    return prefs.getString(
          SPManagerEnum.userFavoriteLastUpdateDate.toString(),
        ) ??
        "";
  }

  bool? showOnboardingPage() {
    return prefs.getBool(SPManagerEnum.showOnboardingPage.toString());
  }

  Future<bool>? setOnboardingPage() {
    return prefs.setBool(SPManagerEnum.showOnboardingPage.toString(), true);
  }

  Future<bool>? setSaveUserAddress(id) {
    return prefs.setInt(SPManagerEnum.setSaveUserAddress.toString(), id);
  }

  int? getUserAddressId() {
    return prefs.getInt(SPManagerEnum.setSaveUserAddress.toString());
  }

  Future<bool>? setTranslationDate(String date) async {
    return await prefs.setString(
      SPManagerEnum.translationDate.toString(),
      date,
    );
  }

  Future<bool>? setUserFavoriteLastUpdateDate(String date) async {
    return await prefs.setString(
      SPManagerEnum.userFavoriteLastUpdateDate.toString(),
      date,
    );
  }

  Future<bool>? refreshDbDateTime() async {
    await setPhoneCodesDate('');

    await setCategoriesDate('');

    await setProductStatusDate('');

    await setCurrenciesDate('');

    return true;
  }

  Future<bool>? setCategoriesDate(String date) async {
    return await prefs.setString(SPManagerEnum.categoriesDate.toString(), date);
  }

  Future<bool>? setPhoneCodesDate(String date) async {
    return await prefs.setString(SPManagerEnum.phoneCodesDate.toString(), date);
  }

  Future<bool>? setCurrenciesDate(String date) async {
    return await prefs.setString(SPManagerEnum.currenciesDate.toString(), date);
  }

  String? getCurrenciesDate() {
    return prefs.getString(SPManagerEnum.currenciesDate.toString()) ?? "";
  }

  Future<bool>? setProductStatusDate(String date) async {
    return await prefs.setString(
      SPManagerEnum.productStatusDate.toString(),
      date,
    );
  }

  String? getProductStatusDate() {
    return prefs.getString(SPManagerEnum.productStatusDate.toString()) ?? "";
  }

  String? getCategoriesDate() {
    return prefs.getString(SPManagerEnum.categoriesDate.toString()) ?? "";
  }

  String? getPhoneCodesDate() {
    return prefs.getString(SPManagerEnum.phoneCodesDate.toString()) ?? "";
  }

  int? getUserId() {
    return prefs.getInt(SPManagerEnum.userId.toString());
  }

  String? getUserName() {
    return prefs.getString(SPManagerEnum.userName.toString());
  }

  String? getRefreshToken() {
    return prefs.getString(SPManagerEnum.refreshToken.toString());
  }

  String? getAccessToken() {
    return prefs.getString(SPManagerEnum.accessToken.toString());
  }

  // Future<void> setAccessToken({required UserInfoDto? info}) async {
  //   await prefs.setString(
  //       SPManagerEnum.accessToken.toString(), info?.token ?? '');

  //   await prefs.setInt(SPManagerEnum.userId.toString(), info?.id ?? -1);
  // }

  Future<void> changeRememberMe({required bool state}) async {
    await prefs.setBool(SPManagerEnum.rememberMe.toString(), state);
  }

  bool? getRememberMe() {
    return prefs.getBool(SPManagerEnum.rememberMe.toString());
  }

  int? getThemeMode() {
    return prefs.getInt(SPManagerEnum.themeMode.toString());
  }

  Future<void> setThemeMode(int themeMode) async {
    await prefs.setInt(SPManagerEnum.themeMode.toString(), themeMode);
  }

  int? getLangId() {
    return prefs.getInt(SPManagerEnum.langCode.toString());
  }

  Future<void> setLangId(int langCode) async {
    await prefs.setInt(SPManagerEnum.langCode.toString(), langCode);
  }

  Future<bool> setCurrencieId(int id) async {
    return await prefs.setInt(SPManagerEnum.currencieId.toString(), id);
  }

  int? getCurrencieId() {
    return prefs.getInt(SPManagerEnum.currencieId.toString());
  }

  String? getLangCode() {
    return prefs.getString(SPManagerEnum.langCodeStr.toString());
  }

  Future<void> setLangCode(String langCode) async {
    await prefs.setString(SPManagerEnum.langCodeStr.toString(), langCode);
  }

  Future<bool> removeRememberMe() async {
    try {
      await prefs.remove(SPManagerEnum.rememberMe.toString());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> changeSyncTaskDate({required String value}) async {
    await prefs.setString(SPManagerEnum.syncTaskDate.toString(), value);
  }

  String? getSyncTaskDate() {
    return prefs.getString(SPManagerEnum.syncTaskDate.toString());
  }

  Future<void> changeDBVersion({required int value}) async {
    await prefs.setInt(SPManagerEnum.activeDBVersion.toString(), value);
  }

  int? getDBVersion() {
    return prefs.getInt(SPManagerEnum.activeDBVersion.toString());
  }

  Future<bool> clearCache() async {
    return await prefs.clear();
  }

  Future<void> removeUserInfo() async {
    await prefs.setString(SPManagerEnum.accessToken.toString(), '');
    await prefs.setInt(SPManagerEnum.userId.toString(), -1);
  }
}
