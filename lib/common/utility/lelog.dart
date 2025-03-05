import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LeLog {
  static String _now() => DateFormat('HH:mm:ss').format(DateTime.now());
  // DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  static final _lelog = dotenv.get("LE_LOG", fallback: "").split(",");

  /// Debug Log
  static void d(dynamic source, String msg) {
    if (!kDebugMode || !_lelog.contains('d')) return;
    debugPrint('LeLog d [${_now()}] [${source.toString()}] $msg');
  }

  /// Error Log
  static void e(dynamic source, String msg) {
    if (!kDebugMode || !_lelog.contains('e')) return;
    debugPrint('LeLog e [${_now()}] [${source.toString()}] $msg');
  }

  /// BLoC
  static String _blocClassToStr(dynamic source) {
    return source.toString().split('\'')[1].trim();
  }

  static String _blocFnToStr(Function fn) {
    return fn.toString().split('\'')[1].trim().split("@")[0].trim();
  }

  /// BLoC Debug Log
  static void bd(dynamic source, Function fn, String msg) {
    if (!kDebugMode || !_lelog.contains('bd')) return;
    debugPrint(
        'LeLog d b [${_now()}] [${_blocClassToStr(source)}] [${_blocFnToStr(fn)}] $msg');
  }

  /// BLoC Error Log
  static void be(dynamic source, Function fn, String msg) {
    if (!kDebugMode || !_lelog.contains('be')) return;
    debugPrint(
        'LeLog e b [${_now()}] [${_blocClassToStr(source)}] [${_blocFnToStr(fn)}] $msg');
  }

  /// Repository
  static String _repositoryClassToStr1(dynamic cls) =>
      cls.toString().split('\'')[1].trim();

  static String _repositoryFnToStr1(Function fn) =>
      fn.toString().split('\'')[1].trim();

  static void rd(dynamic source, Function fn, String msg) {
    if (!kDebugMode || !_lelog.contains('rd')) return;
    debugPrint(
        'LeLog d r [${_now()}] [${_repositoryClassToStr1(source)}] [${_repositoryFnToStr1(fn)}] $msg');
  }

  static void re(dynamic source, Function fn, String msg) {
    if (!kDebugMode || !_lelog.contains('re')) return;
    debugPrint(
        'LeLog e r [${_now()}] [${_repositoryClassToStr1(source)}] [${_repositoryFnToStr1(fn)}] $msg');
  }

  /// Screen
  static String _screenClassToStr(dynamic cls) =>
      cls.toString().split('#')[0].trim();

  static String _screenFnToStr2(Function fn) =>
      fn.toString().split('\'')[1].split('@')[0].trim();

  /// Screen Debug Log
  static void sd(dynamic source, Function fn, String msg) {
    if (!kDebugMode || !_lelog.contains('sd')) return;
    debugPrint(
        'LeLog d s [${_now()}] [${_screenClassToStr(source)}] [${_screenFnToStr2(fn)}] $msg');
  }

  /// Screen Error Log
  static void se(dynamic source, Function fn, String msg) {
    if (!kDebugMode || !_lelog.contains('se')) return;
    debugPrint(
        'LeLog e s [${_now()}] [${_screenClassToStr(source)}] [${_screenFnToStr2(fn)}] $msg');
  }
}

// /// Debug Log
// static void d(dynamic source, String msg) {
//   if (!kDebugMode) return;
//   debugPrint('LeLog d [${_now()}] [${source.toString()}] $msg');
// }

// /// Error Log
// static void e(dynamic source, String msg) {
//   if (!kDebugMode) return;
//   debugPrint('LeLog e [${_now()}] [${source.toString()}] $msg');
// }

// /// Page / Screen Debug Log
// static void pd(dynamic source, Function fn, String msg) {
//   if (!kDebugMode) return;
//   debugPrint(
//       'LeLog d p [${_now()}] [${_classToStr2(source)}] [${_fnToStr2(fn)}] $msg');
// }

// /// Page / Screen Error Log
// static void pe(dynamic source, Function fn, String msg) {
//   if (!kDebugMode) return;
//   debugPrint(
//       'LeLog e p [${_now()}] [${_classToStr2(source)}] [${_fnToStr2(fn)}] $msg');
// }

// /// Controller Debug Log
// static void cd(dynamic source, Function fn, String msg) {
//   if (!kDebugMode) return;
//   debugPrint(
//       'LeLog d c [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
// }

// /// Controller Error Log
// static void ce(dynamic source, Function fn, String msg) {
//   if (!kDebugMode) return;
//   debugPrint(
//       'LeLog e c [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
// }

// /// Service Debug Log
// static void sd(dynamic source, Function fn, String msg) {
//   if (!kDebugMode) return;
//   debugPrint(
//       'LeLog d s [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
// }

// /// Service Error Log
// static void se(dynamic source, Function fn, String msg) {
//   if (!kDebugMode) return;
//   debugPrint(
//       'LeLog e s [${_now()}] [${_classToStr1(source)}] [${_fnToStr1(fn)}] $msg');
// }
