enum ParameterEnum {
  reviewReport('REVIEW', 'REPORT'),
  placeReport('FNB', 'REPORT');

  final String div;
  final String subDiv;

  const ParameterEnum(this.div, this.subDiv);

  Map<String, String> toMap() {
    return Map.from({
      'div': div,
      'subDiv': subDiv,
    });
  }

  String toHiveKey() {
    return '${div}_$subDiv';
  }
}
