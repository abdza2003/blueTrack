import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/enum/image_menu_enum.dart';
import 'package:bluetrack/core/extension/image_menu_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextPostFontTypesEnum {
  poppinsBold(id: 1, family: 'poppins', fontWeight: FontWeight.bold),
  poppins(id: 2, family: 'poppins', fontWeight: FontWeight.normal),

  almarai(id: 3, family: 'almarai', fontWeight: FontWeight.normal),
  almaraibold(id: 4, family: 'almarai', fontWeight: FontWeight.bold),

  nerkoOne(id: 5, family: 'NerkoOne', fontWeight: FontWeight.normal),

  nerkoOneBold(id: 6, family: 'NerkoOne', fontWeight: FontWeight.bold),

  fustatBold(
    id: 7,
    family: 'Fustat-VariableFont_wght',
    fontWeight: FontWeight.bold,
  ),

  fustat(
    id: 8,
    family: 'Fustat-VariableFont_wght',
    fontWeight: FontWeight.normal,
  ),

  arefRuqaa(id: 9, family: 'ArefRuqaa-Regular', fontWeight: FontWeight.normal),
  arefRuqaaBold(id: 10, family: 'ArefRuqaa-Bold', fontWeight: FontWeight.bold),

  courgette(id: 11, family: 'courgette', fontWeight: FontWeight.normal),
  courgetteBold(id: 12, family: 'courgette', fontWeight: FontWeight.bold);

  const TextPostFontTypesEnum({
    required this.id,
    required this.family,
    required this.fontWeight,
  });

  final String family;
  final FontWeight fontWeight;
  final int id;

  factory TextPostFontTypesEnum.fromWord(String word) {
    return TextPostFontTypesEnum.values.firstWhere(
      (category) => category.family == word,
    );
  }

  @override
  String toString() => family;
}
