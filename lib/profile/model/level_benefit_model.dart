// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LevelBenefitModel {
  final String benefitTitle;
  final String benefitContent;

  LevelBenefitModel({
    required this.benefitTitle,
    required this.benefitContent,
  });

  LevelBenefitModel copyWith({
    String? benefitTitle,
    String? benefitContent,
  }) {
    return LevelBenefitModel(
      benefitTitle: benefitTitle ?? this.benefitTitle,
      benefitContent: benefitContent ?? this.benefitContent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'benefitTitle': benefitTitle,
      'benefitContent': benefitContent,
    };
  }

  factory LevelBenefitModel.fromMap(Map<String, dynamic> map) {
    return LevelBenefitModel(
      benefitTitle: map['benefitTitle'] as String,
      benefitContent: map['benefitContent'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LevelBenefitModel.fromJson(String source) =>
      LevelBenefitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LevelBenefitModel(benefitTitle: $benefitTitle, benefitContent: $benefitContent)';

  @override
  bool operator ==(covariant LevelBenefitModel other) {
    if (identical(this, other)) return true;

    return other.benefitTitle == benefitTitle &&
        other.benefitContent == benefitContent;
  }

  @override
  int get hashCode => benefitTitle.hashCode ^ benefitContent.hashCode;
}
