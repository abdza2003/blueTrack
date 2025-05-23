enum CurrenciesEnum {
  dollar(id: 1, title: 'dollar'),
  turkishLira(id: 2, title: 'turkishLira'),
  syrianLira(id: 3, title: 'syrianLira'),
  ;

  const CurrenciesEnum({
    required this.title,
    required this.id,
  });

  final String title;
  final int id;

  factory CurrenciesEnum.fromWord(String word) {
    return CurrenciesEnum.values.firstWhere(
      (category) => category.title == word,
    );
  }

  @override
  String toString() => title;
}
