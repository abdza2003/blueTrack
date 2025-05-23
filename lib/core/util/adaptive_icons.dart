import 'dart:io';

import 'package:flutter/cupertino.dart';

IconData getIconBasedOnPlatform(IconData iosIcon, IconData androidIcon) {
  return Platform.isIOS || Platform.isMacOS ? iosIcon : androidIcon;
}
