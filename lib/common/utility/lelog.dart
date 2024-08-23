import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class LeLog {
  static String _fnToStr1(Function fn) => fn.toString().split('\'')[1].trim();

  static String _fnToStr2(Function fn) =>
      fn.toString().split('\'')[1].split('@')[0].trim();

  // Used for Controller and Service (Riverpod)
  static String _classToStr1(dynamic cls) =>
      cls.toString().split('\'')[1].trim();

  // Used for Page or Screen
  static String _classToStr2(dynamic cls) =>
      cls.toString().split('#')[0].trim();

  static String _now() =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  /// Debug Log
  static void d(dynamic source, String msg) {
    if (!kDebugMode) return;
    debugPrint('LeLog d [${_now()}] [${source.toString()}] $msg');
  }

  /// Error Log
  static void e(dynamic source, String msg) {
    if (!kDebugMode) return;
    debugPrint('LeLog e [${_now()}] [${source.toString()}] $msg');
  }

  /// Page / Screen Debug Log
  static void pd(dynamic source, Function fn, String msg) {
    if (!kDebugMode) return;
    debugPrint(
        'LeLog d p [${_now()}] [${_classToStr2(source)}] [${_fnToStr2(fn)}] $msg');
  }

  /// Page / Screen Error Log
  static void pe(dynamic source, Function fn, String msg) {
    if (!kDebugMode) return;
    debugPrint(
        'LeLog e p [${_now()}] [${_classToStr2(source)}] [${_fnToStr2(fn)}] $msg');
  }

  /// Controller Debug Log
  static void cd(dynamic source, Function fn, String msg) {
    if (!kDebugMode) return;
    debugPrint(
        'LeLog d c [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
  }

  /// Controller Error Log
  static void ce(dynamic source, Function fn, String msg) {
    if (!kDebugMode) return;
    debugPrint(
        'LeLog e c [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
  }

  /// Service Debug Log
  static void sd(dynamic source, Function fn, String msg) {
    if (!kDebugMode) return;
    debugPrint(
        'LeLog d s [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
  }

  /// Service Error Log
  static void se(dynamic source, Function fn, String msg) {
    if (!kDebugMode) return;
    debugPrint(
        'LeLog e s [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
  }
}
