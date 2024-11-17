class SuggestionRepository {
  final List<String> _homeSuggestionDummy = [
    "Hari Kemerdekaan",
    'Table 8',
    'Starkbuck',
    "Kopi Kenangan",
    "Letto 12",
  ];

  final List<String> _fnbSuggestionDummy = [
    "Makan Nasi",
    "KFC",
    "Lemper",
    "Mie",
    "Jus buah",
  ];
  Future<List<String>> getHomeSuggestion() async {
    return _homeSuggestionDummy;
  }

  Future<List<String>> getFnbSuggestion() async {
    return _fnbSuggestionDummy;
  }
}
