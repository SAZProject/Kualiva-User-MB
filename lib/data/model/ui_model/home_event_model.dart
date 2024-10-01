// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HomeEventModel {
  final String imagePath;
  final String eventTitle;
  final String eventDate;
  final String eventHost;
  final String eventDesc;

  HomeEventModel({
    required this.imagePath,
    required this.eventTitle,
    required this.eventDate,
    required this.eventHost,
    required this.eventDesc,
  });

  HomeEventModel copyWith({
    String? imagePath,
    String? eventTitle,
    String? eventDate,
    String? eventHost,
    String? eventDesc,
  }) {
    return HomeEventModel(
      imagePath: imagePath ?? this.imagePath,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDate: eventDate ?? this.eventDate,
      eventHost: eventHost ?? this.eventHost,
      eventDesc: eventDesc ?? this.eventDesc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'eventTitle': eventTitle,
      'eventDate': eventDate,
      'eventHost': eventHost,
      'eventDesc': eventDesc,
    };
  }

  factory HomeEventModel.fromMap(Map<String, dynamic> map) {
    return HomeEventModel(
      imagePath: map['imagePath'] as String,
      eventTitle: map['eventTitle'] as String,
      eventDate: map['eventDate'] as String,
      eventHost: map['eventHost'] as String,
      eventDesc: map['eventDesc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeEventModel.fromJson(String source) =>
      HomeEventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeEventModel(imagePath: $imagePath, eventTitle: $eventTitle, eventDate: $eventDate, eventHost: $eventHost, eventDesc: $eventDesc)';
  }

  @override
  bool operator ==(covariant HomeEventModel other) {
    if (identical(this, other)) return true;

    return other.imagePath == imagePath &&
        other.eventTitle == eventTitle &&
        other.eventDate == eventDate &&
        other.eventHost == eventHost &&
        other.eventDesc == eventDesc;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        eventTitle.hashCode ^
        eventDate.hashCode ^
        eventHost.hashCode ^
        eventDesc.hashCode;
  }
}
