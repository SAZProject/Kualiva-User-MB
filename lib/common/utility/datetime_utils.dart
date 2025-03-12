import 'dart:io';

import 'package:intl/intl.dart';
import 'package:kualiva/_data/model/util_model/get_time_g_api_util_model.dart';
import 'package:kualiva/common/utility/lelog.dart';

/*
Based on dart default
0, 1, 2, 3, 4, 5, 6
sun, mon, tue, wed, thur, fri, sat
*/

class DatetimeUtils {
  final now = DateTime.now();

  static String getDays(int index) {
    var days = DateFormat.EEEE(Platform.localeName).dateSymbols.WEEKDAYS;

    if (index == 6) {
      return days[0];
    } else {
      return days[index + 1];
    }
  }

  static String getHour(DateTime getTime) {
    String getFormatTime = DateFormat.Hm().format(getTime);
    return getFormatTime;
  }

  static GetTimeGApiUtilModel getOpenHourGAPIFormat(String input) {
    // Regular expression to extract hours and minutes
    RegExp regex = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)');
    // Find all matches
    Iterable<RegExpMatch> matches = regex.allMatches(input);

    if (matches.length >= 2) {
      // Extract first time (opening time)
      var firstMatch = matches.elementAt(0);
      int openHour = int.parse(firstMatch.group(1)!);
      int openMinute = int.parse(firstMatch.group(2)!);
      String timePeriod = firstMatch.group(3)!;

      // Convert to 24-hour format if needed
      if (timePeriod == "PM" && openHour != 12) {
        openHour += 12;
      } else if (timePeriod == "AM" && openHour == 12) {
        openHour = 0;
      }

      LeLog.d(getOpenHourGAPIFormat, "Opening Time: $openHour:$openMinute");
      return GetTimeGApiUtilModel(hour: openHour, minute: openMinute);
    }

    return GetTimeGApiUtilModel(hour: null, minute: null);
  }

  static GetTimeGApiUtilModel getCloseHourGAPIFormat(String input) {
    // Regular expression to extract hours and minutes
    RegExp regex = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)');
    // Find all matches
    Iterable<RegExpMatch> matches = regex.allMatches(input);

    if (matches.length >= 2) {
      // Extract second time (closing time)
      var secondMatch = matches.elementAt(1);
      int closeHour = int.parse(secondMatch.group(1)!);
      int closeMinute = int.parse(secondMatch.group(2)!);
      String timePeriod = secondMatch.group(3)!;

      // Convert to 24-hour format if needed
      if (timePeriod == "PM" && closeHour != 12) {
        closeHour += 12;
      } else if (timePeriod == "AM" && closeHour == 12) {
        closeHour = 0;
      }

      LeLog.d(getCloseHourGAPIFormat, "Closing Time: $closeHour:$closeMinute");
      return GetTimeGApiUtilModel(hour: closeHour, minute: closeMinute);
    }

    return GetTimeGApiUtilModel(hour: null, minute: null);
  }

  static String dmy(DateTime getTime) {
    String getFormatTime = DateFormat("d MMM y").format(getTime);
    return getFormatTime;
  }

  /// TODO Fixing sort daay, order day, only need retest on values 7 days
  /// Please test on sunday too
  static int getTodayOperationalTime() {
    List<String> days =
        DateFormat.EEEE(Platform.localeName).dateSymbols.WEEKDAYS;
    int day = days.indexOf(days[DateTime.now().weekday - 1]);
    return day;
  }
}
