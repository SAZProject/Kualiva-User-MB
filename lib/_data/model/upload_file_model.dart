// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UploadFileModel {
  final String imageUrl;
  final String pathUrl;
  final String message;

  UploadFileModel({
    required this.imageUrl,
    required this.pathUrl,
    required this.message,
  });

  UploadFileModel copyWith({
    String? imageUrl,
    String? pathUrl,
    String? message,
  }) {
    return UploadFileModel(
      imageUrl: imageUrl ?? this.imageUrl,
      pathUrl: pathUrl ?? this.pathUrl,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'pathUrl': pathUrl,
      'message': message,
    };
  }

  factory UploadFileModel.fromMap(Map<String, dynamic> map) {
    return UploadFileModel(
      imageUrl: map['imageUrl'] as String,
      pathUrl: map['pathUrl'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadFileModel.fromJson(String source) =>
      UploadFileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UploadFileModel(imageUrl: $imageUrl, pathUrl: $pathUrl, message: $message)';

  @override
  bool operator ==(covariant UploadFileModel other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.pathUrl == pathUrl &&
        other.message == message;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ pathUrl.hashCode ^ message.hashCode;
}
