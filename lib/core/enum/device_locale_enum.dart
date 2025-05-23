enum DeviceLocaleEnum {
  arabic(id: 1, title: 'اللغة العربية', langCode: 'ar'),
  english(id: 2, title: 'English', langCode: 'en'),
  ;

  const DeviceLocaleEnum({
    required this.title,
    required this.id,
    required this.langCode,
  });

  final String title;
  final String langCode;
  final int id;

  factory DeviceLocaleEnum.fromWord(String word) {
    return DeviceLocaleEnum.values.firstWhere(
      (category) => category.title == word,
    );
  }

  @override
  String toString() => title;
}
