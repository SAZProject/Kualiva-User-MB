import 'dart:io';

import 'package:intl/intl.dart';

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

  static String dmy(DateTime getTime) {
    String getFormatTime = DateFormat.yMMMd().format(getTime);
    return getFormatTime;
  }

  static int getTodayOperationalTime() {
    var days = DateFormat.EEEE(Platform.localeName).dateSymbols.WEEKDAYS;
    int day = days.indexOf(days[DateTime.now().weekday]);
    if (day == 0) {
      return 6;
    } else {
      return day - 1;
    }
  }
}
