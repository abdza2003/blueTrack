import 'package:flutter/cupertino.dart';
import 'package:bluetrack/core/components/hex_color.dart';
import 'package:flutter/material.dart';

class ColorConstants {
  static final ColorConstants instance = ColorConstants._internal();

  ColorConstants._internal();

  final black = const Color(0xFF000000);
  final sandyBeach = const Color(0xFFFFECCC);
  final mischka = const Color(0xFFEBEAEC);
  final brightGray = const Color(0xFF3F414E);
  final gullGray = const Color(0xFF96A7AF);
  final ebonyClay = const Color(0xFF22343C);
  final malibu = const Color(0xFF8E97FD);
  final white = const Color(0xFFFFFFFF);
  final linkWater = const Color(0xFFEDF1FA);
  final chardonnay = const Color(0xFFFFCF86);
  final anakiwa = const Color(0xFF8EDCFD);
  final bitterSweet = const Color(0xFFFA6E5A);
  final valencia = const Color(0xFFD53D3D);
  final silverTree = const Color(0xFF6CB28E);
  final santasGray = const Color(0xFFA0A3B1);
  final azureRadiance = const Color(0xFF007AFF);
  final plantation = const Color(0xFF286053);
  final shamrock = const Color(0xFF3DD598);
  final buccaneer = const Color(0xFF602828);
  final viking = const Color(0xFF5BC8E1);
  final wedgeWood = const Color(0xFF3F8798);
  final alto = const Color(0xFFDCDBDB);
  final gold = const Color(0xFFFFD300);
  //SABİLGİ
  final blueBayoux = const Color(0xff525D7A);
  final seaGreen = const Color(0xff349663);

  final doneColor = HexColor('#39D249');
  final postBackgroundMainColor = '#03a9f4';
  final primaryHexColor = '#1A1A1A';
  // final primary = CupertinoColors.activeBlue;
  final primary = HexColor("#CA7842");
  final errorColor = HexColor('#F34A63');
  final darkColor = HexColor('#212121');
  final lightModeBackground = HexColor('#f5f5f5');
  final darkModeBackground = HexColor('#2b2b2b');
  final darkModeSecondaryColor = HexColor('#1d1d1d');

  // final darkModeSecondaryColor = HexColor('#1f1f1f');
  // final darkModeSecondaryColor = HexColor('#1a1a1a');

  final List<Color> primaryColors = [
    Colors.pink.shade300,
    Colors.purple.shade500,
    Colors.cyan.shade500,
    Colors.teal.shade300,
  ];
}
