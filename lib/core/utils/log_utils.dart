import 'package:flutter/foundation.dart';

class LogUtils {
  static logE({message: String}) {
    if (kDebugMode) {
      print("RHM: $message");
    }
  }

  static void log(dynamic data) {
    if (kDebugMode) {
      print('=====RHM===');
      print(data);
      print('================');
    }
  }
}
