import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/bus_service.dart';
import 'package:mobile_rhm/app_services/story/calendar/calendar_service_helper.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar_task_response.dart';
import 'package:mobile_rhm/data/model/response/calendar/task_calendar.dart';

import '../../../data/repository_manager.dart';
import '../../../di/components/service_locator.dart';

class CalendarService extends GetxService with CalendarServiceHelper {
  final RepositoryManager _repositoryManager = getIt<RepositoryManager>();
  final EventBusService _eventBusService = Get.find<EventBusService>();
  List<CalendarTask> calendarTask = [];

  @override
  Future<AllLichHenResponse?> getTasksCalendar({int? page}) async {
    try {
      AllLichHenResponse? res = await _repositoryManager.getTasksCalendar(page: page);
      return res;
    } catch (e) {
      LogUtils.logE(message: '#getTasksCalendar error cause ${e.toString()}');
    }
    return null;
  }

  @override
  Future createOrUpdateTask({required Dio.FormData data, required bool isCreateNew}) async {
    var res = await _repositoryManager.createOrUpdateTaskCalendar(formData: data, isCreateNew: isCreateNew);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventNewTaskAdd());
    }
    return res;
  }

  @override
  Future deleteFileOfSubTask({required request}) async {
    var res = await _repositoryManager.deleteFileOfSubTask(request: request);
    if (res['status'] == true) {
      _eventBusService.fireEvent(event: EventUpdateTask());
    }
    return res;
  }

  @override
  Future addNewReview({required Dio.FormData data}) async {
    try {
      var res = await _repositoryManager.addNewReview(formData: data);
      if (res['status'] == true) {
        _eventBusService.fireEvent(event: EventUpdateSingleReport());
      }
      return res;
    } catch (e) {
      return null;
    }
  }

  @override
  Future createOrUpdateSubTask({required Dio.FormData formData, required bool isCreateNew}) {
    // TODO: implement createOrUpdateSubTask
    throw UnimplementedError();
  }

  @override
  Future deleteTaskCalendar({required Dio.FormData formData}) async {
    try {
      // Gọi repository để lấy chi tiết công việc theo ID từ FormData
      var res = await _repositoryManager.deleteTaskCalendar(formData: formData);
      return res; // Trả về kết quả trực tiếp từ repository
    } catch (e) {
      LogUtils.logE(message: 'getTaskCalendarById ${e.toString()}');
      return null; // Trả về null nếu có lỗi
    }
  }

  @override
  Future reviewTaskCalendar({required int calendar_id}) {
    // TODO: implement reviewTaskCalendar
    throw UnimplementedError();
  }

  @override
  Future<List<CalendarTask>?> getAllTaskCalendar({required String? begin, required String? end}) async {
    try {
      var res = await _repositoryManager.getAllTaskCalendar(
          begin: begin, end: end);
      LogUtils.logE(message: 'getAllTaskCalendar ${res}');
      if (res != null) {
        calendarTask.clear();
        calendarTask.addAll(res);
      }
    } catch (e) {
      LogUtils.logE(message: 'getAllTaskCalendar ${e.toString()}');
    }
    return calendarTask;
  }

  @override
  Future<CalendarTaskResponse?> getTaskCalendarById({required Dio.FormData formData}) async {
    try {
      // Gọi repository để lấy chi tiết công việc theo ID từ FormData
      var res = await _repositoryManager.getTaskCalendarById(formData: formData);
      return res; // Trả về kết quả trực tiếp từ repository
    } catch (e) {
      LogUtils.logE(message: 'getTaskCalendarById ${e.toString()}');
      return null; // Trả về null nếu có lỗi
    }
  }
  @override
  Future updateStatus({required num id}) async {
    try {
      var res = await _repositoryManager.updateStatus(id: id);
      return res;
    } catch (e) {
      return null;
    }
  }
}
