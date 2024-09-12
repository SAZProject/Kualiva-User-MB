import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeUtils {
  final now = DateTime.now();

  static String getDays(int index) {
    var days = DateFormat.EEEE(Platform.localeName).dateSymbols.WEEKDAYS;
    debugPrint(days.toString());

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
}
