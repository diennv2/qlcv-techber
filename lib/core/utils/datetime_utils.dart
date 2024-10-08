import 'package:intl/intl.dart';
import 'package:mobile_rhm/core/extentions/string.dart';

class DateTimeUtils {
  static String? formatDateTimeBE({required String? beDateTime}) {
    if (beDateTime.isNullOrBlank) {
      return null;
    }
    DateTime dateTime = DateTime.parse(beDateTime!);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static DateTime getDateTimeBE({required String beDateTime}) {
    DateTime dateTime = DateTime.parse(beDateTime);
    return dateTime;
  }

  static String timeDifference(String isoTime) {
    DateTime givenTime = DateTime.parse(isoTime);
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(givenTime);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years năm trước';
    } else if (difference.inDays > 30) {
      int months = (difference.inDays / 30).floor();
      return '$months tháng trước';
    } else if (difference.inDays > 7) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks tuần trước';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} phút trước';
    } else {
      return '${difference.inSeconds} giây trước';
    }
  }
}
