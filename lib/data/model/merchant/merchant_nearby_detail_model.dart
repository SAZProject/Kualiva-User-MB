// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MerchantNearbyDetailModel {}

@immutable
class AddressComponents {
  final String longName;
  final String shortName;
  final List<String> types;
  const AddressComponents({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  AddressComponents copyWith({
    String? longName,
    String? shortName,
    List<String>? types,
  }) {
    return AddressComponents(
      longName: longName ?? this.longName,
      shortName: shortName ?? this.shortName,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'longName': longName,
      'shortName': shortName,
      'types': types,
    };
  }

  factory AddressComponents.fromMap(Map<String, dynamic> map) {
    return AddressComponents(
      longName: map['long_name'] as String,
      shortName: map['short_name'] as String,
      types: (map['types'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressComponents.fromJson(String source) =>
      AddressComponents.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddressComponents(longName: $longName, shortName: $shortName, types: $types)';

  @override
  bool operator ==(covariant AddressComponents other) {
    if (identical(this, other)) return true;

    return other.longName == longName &&
        other.shortName == shortName &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode => longName.hashCode ^ shortName.hashCode ^ types.hashCode;
}

@immutable
class CurrentOpeningHours {
  final bool openNow;
  final List<Periods> periods;
  final List<String> weekdayText;

  const CurrentOpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  CurrentOpeningHours copyWith({
    bool? openNow,
    List<Periods>? periods,
    List<String>? weekdayText,
  }) {
    return CurrentOpeningHours(
      openNow: openNow ?? this.openNow,
      periods: periods ?? this.periods,
      weekdayText: weekdayText ?? this.weekdayText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'open_now': openNow,
      'periods': periods.map((x) => x.toMap()).toList(),
      'weekday_text': weekdayText,
    };
  }

  factory CurrentOpeningHours.fromMap(Map<String, dynamic> map) {
    return CurrentOpeningHours(
      openNow: map['openNow'] as bool,
      periods: (map['periods'] as List<dynamic>)
          .map((e) => Periods.fromMap(e))
          .toList(),
      weekdayText: (map['weekdayText'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentOpeningHours.fromJson(String source) =>
      CurrentOpeningHours.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CurrentOpeningHours(openNow: $openNow, periods: $periods, weekdayText: $weekdayText)';

  @override
  bool operator ==(covariant CurrentOpeningHours other) {
    if (identical(this, other)) return true;

    return other.openNow == openNow &&
        listEquals(other.periods, periods) &&
        listEquals(other.weekdayText, weekdayText);
  }

  @override
  int get hashCode =>
      openNow.hashCode ^ periods.hashCode ^ weekdayText.hashCode;
}

@immutable
class Periods {
  final OpenClose close;
  final OpenClose open;

  const Periods({
    required this.close,
    required this.open,
  });

  Periods copyWith({
    OpenClose? close,
    OpenClose? open,
  }) {
    return Periods(
      close: close ?? this.close,
      open: open ?? this.open,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'close': close.toMap(),
      'open': open.toMap(),
    };
  }

  factory Periods.fromMap(Map<String, dynamic> map) {
    return Periods(
      close: OpenClose.fromMap(map['close'] as Map<String, dynamic>),
      open: OpenClose.fromMap(map['open'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Periods.fromJson(String source) =>
      Periods.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Periods(close: $close, open: $open)';

  @override
  bool operator ==(covariant Periods other) {
    if (identical(this, other)) return true;

    return other.close == close && other.open == open;
  }

  @override
  int get hashCode => close.hashCode ^ open.hashCode;
}

@immutable
class OpenClose {
  final DateTime date;
  final int day;
  final String time;
  final bool truncated;

  const OpenClose({
    required this.date,
    required this.day,
    required this.time,
    required this.truncated,
  });

  OpenClose copyWith({
    DateTime? date,
    int? day,
    String? time,
    bool? truncated,
  }) {
    return OpenClose(
      date: date ?? this.date,
      day: day ?? this.day,
      time: time ?? this.time,
      truncated: truncated ?? this.truncated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'day': day,
      'time': time,
      'truncated': truncated,
    };
  }

  factory OpenClose.fromMap(Map<String, dynamic> map) {
    return OpenClose(
      date: DateTime.parse(map['date']),
      day: map['day'] as int,
      time: map['time'] as String,
      truncated: map['truncated'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OpenClose.fromJson(String source) =>
      OpenClose.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OpenClose(date: $date, day: $day, time: $time, truncated: $truncated)';
  }

  @override
  bool operator ==(covariant OpenClose other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.day == day &&
        other.time == time &&
        other.truncated == truncated;
  }

  @override
  int get hashCode {
    return date.hashCode ^ day.hashCode ^ time.hashCode ^ truncated.hashCode;
  }
}

@immutable
class Geometry {
  final Location location;
  final Viewport viewport;

  const Geometry({
    required this.location,
    required this.viewport,
  });

  Geometry copyWith({
    Location? location,
    Viewport? viewport,
  }) {
    return Geometry(
      location: location ?? this.location,
      viewport: viewport ?? this.viewport,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
      'viewport': viewport.toMap(),
    };
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      viewport: Viewport.fromMap(map['viewport'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Geometry.fromJson(String source) =>
      Geometry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Geometry(location: $location, viewport: $viewport)';

  @override
  bool operator ==(covariant Geometry other) {
    if (identical(this, other)) return true;

    return other.location == location && other.viewport == viewport;
  }

  @override
  int get hashCode => location.hashCode ^ viewport.hashCode;
}

@immutable
class Location {
  final double lat;
  final double lng;

  const Location({
    required this.lat,
    required this.lng,
  });

  Location copyWith({
    double? lat,
    double? lng,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Location(lat: $lat, lng: $lng)';

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}

@immutable
class Viewport {
  final Location northeast;
  final Location southwest;

  const Viewport({
    required this.northeast,
    required this.southwest,
  });

  Viewport copyWith({
    Location? northeast,
    Location? southwest,
  }) {
    return Viewport(
      northeast: northeast ?? this.northeast,
      southwest: southwest ?? this.southwest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'northeast': northeast.toMap(),
      'southwest': southwest.toMap(),
    };
  }

  factory Viewport.fromMap(Map<String, dynamic> map) {
    return Viewport(
      northeast: Location.fromMap(map['northeast'] as Map<String, dynamic>),
      southwest: Location.fromMap(map['southwest'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Viewport.fromJson(String source) =>
      Viewport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ViewPort(northeast: $northeast, southwest: $southwest)';

  @override
  bool operator ==(covariant Viewport other) {
    if (identical(this, other)) return true;

    return other.northeast == northeast && other.southwest == southwest;
  }

  @override
  int get hashCode => northeast.hashCode ^ southwest.hashCode;
}
