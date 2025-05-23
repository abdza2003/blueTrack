String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String obfuscateName(String? name) {
  if (name == null || name.isEmpty) {
    return '';
  }

  // تقسيم الاسم إلى كلمات
  List<String> words = name.split(' ');

  // معالجة كل كلمة لإظهار أول حرفين فقط
  List<String> obfuscatedWords = words.map((word) {
    if (word.length <= 2) {
      return word; // إذا كانت الكلمة أقل من حرفين، اتركها كما هي
    }
    return '${word.substring(0, 2)}${'*' * (word.length - 2)}'; // إظهار أول حرفين والباقي نجوم
  }).toList();

  // إعادة تجميع الكلمات
  return obfuscatedWords.join(' ');
}
