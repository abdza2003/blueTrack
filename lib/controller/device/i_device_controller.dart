import 'package:bluetrack/core/enum/device_locale_enum.dart';
import 'package:flutter/cupertino.dart';

abstract class IDeviceController extends ChangeNotifier {
  setThemeMode(BuildContext context);
  getThemeMode();
  setLangCode(BuildContext context, DeviceLocaleEnum deviceLocaleEnum);
}
