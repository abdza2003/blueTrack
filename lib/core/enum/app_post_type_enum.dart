import 'package:bluetrack/core/constants/image_constant.dart';
import 'package:bluetrack/core/enum/image_menu_enum.dart';
import 'package:bluetrack/core/extension/image_menu_extension.dart';

enum AppPostTypeEnum {
  textType(id: 0, title: 'text_type', icon: 'assets/icons/post_type (1).png'),
  imageType(id: 1, title: 'image_type', icon: 'assets/icons/post_type (5).png');

  const AppPostTypeEnum({
    required this.id,
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;
  final int id;

  factory AppPostTypeEnum.fromWord(String word) {
    return AppPostTypeEnum.values.firstWhere(
      (category) => category.title == word,
    );
  }

  @override
  String toString() => title;
}
