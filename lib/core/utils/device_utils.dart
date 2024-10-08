//
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Helper class for device related operations.
///
class DeviceUtils {
  ///
  /// hides the keyboard if its already open
  ///
  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// orientation
  ///
  static double getScaledSize(BuildContext context, double scale) =>
      scale * (MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height);

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// width
  ///
  static double getScaledWidth(BuildContext context, double scale) => scale * MediaQuery.of(context).size.width;

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// height
  ///
  static double getScaledHeight(BuildContext context, double scale) => scale * MediaQuery.of(context).size.height;

  static Size textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  static double statusBarHeight() {
    return MediaQuery.of(Get.context!).viewPadding.top + 8;
  }

  static double convertBytesToMegabytes(int bytes) {
    return bytes / (1024 * 1024);
  }
}
