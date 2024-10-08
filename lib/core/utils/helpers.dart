import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class CommonUtils {
  static bool isValidString({String? param}) {
    return param != null && param != '' && param.trim() != '';
  }

  static bool isValidPhoneNumber({required String param}) {
    return param != '' && param.trim() != '';
  }

  static bool isValidPassword({required String password}) {
    // Regex để kiểm tra điều kiện mật khẩu
    String pattern = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{12,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  static bool isValidEmail({required String email}) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  static String diffTimes({required String inputTime}) {
    DateTime input = DateTime.parse(inputTime);
    DateTime currentTime = DateTime.now();
    var diffDays = currentTime.difference(input).inDays;
    var diffHours = currentTime.difference(input).inHours;

    if (diffHours < 24) {
      return '$diffHours giờ trước';
    }

    if (diffDays < 7) return '$diffDays ngày trước';

    if (diffDays < 31) {
      int weeks = diffDays ~/ 7;
      return '$weeks tuần trước';
    }

    if (diffDays < 365) {
      int month = diffDays ~/ 30;
      return '$month tháng trước';
    }

    int years = diffDays ~/ 365;
    return '$years năm trước';
  }

  static String formatDateTime({required String inputTime}) {
    if (inputTime == '') {
      return '';
    }
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      DateTime dateTime = dateFormat.parse(inputTime);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {}

    return '';
  }

  static String formatDateTimeEx({required String inputTime}) {
    if (inputTime == '') {
      return '';
    }
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      DateTime dateTime = dateFormat.parse(inputTime);
      return '${dateTime.hour + 7}:${dateTime.minute} ${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {}

    return '';
  }

  static DateTime getDateTime({required String inputTime}) {
    if (inputTime == '') {
      return DateTime.now();
    }
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      DateTime dateTime = dateFormat.parse(inputTime);
      return dateTime;
    } catch (e) {}

    return DateTime.now();
  }

  static String getFileNameFromPath({required String filePath}) {
    String result = '';
    List<String> paths = filePath.split('/');
    if (paths.isNotEmpty) {
      return paths.last;
    }
    return result;
  }

  static String trimFirstLastString({required String input}) {
    String res = input;
    if (res.isNotEmpty) {
      if (res.startsWith(' ')) {
        while (res.startsWith(' ')) {
          res = res.substring(1);
        }
      }
      if (res.endsWith(' ')) {
        while (res.endsWith(' ')) {
          res = res.substring(0, res.length - 1);
        }
      }
    }
    return res;
  }

  static Color hexToColor({String? hexString}) {
    if (hexString.isNullOrEmpty) {
      return AppColors.PrimaryText;
    }
    hexString = hexString!.toUpperCase().replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF$hexString";
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
