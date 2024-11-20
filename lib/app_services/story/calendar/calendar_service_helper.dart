import 'package:dio/dio.dart';

import '../../../data/model/response/calendar/calendar.dart';

abstract class CalendarServiceHelper {
  Future<List<CalendarTask>?> getAllTaskCalendar({required String? begin, required String? end});

  Future createOrUpdateSubTask({required FormData formData, required bool isCreateNew});
  Future reviewTaskCalendar({required int calendar_id});
  Future deleteTaskCalendar({required FormData formData});
}
