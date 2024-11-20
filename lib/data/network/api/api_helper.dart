import 'package:dio/dio.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar_task_response.dart';
import 'package:mobile_rhm/data/model/response/calendar/task_calendar.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:mobile_rhm/data/model/response/notification/notification.dart';
import 'package:mobile_rhm/data/model/response/task/co_quan.dart';
import 'package:mobile_rhm/data/model/response/task/commment_list.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/lanh_dao.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';
import 'package:mobile_rhm/data/model/response/task/type_of_work.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';

import '../../model/response/calendar/calendar.dart';
import '../../model/response/task/phong_ban.dart';
import '../../model/response/task/sub_task_progress_response.dart';
import '../../model/response/task/task.dart';

abstract class ApiHelper {
  //Get domain list
  Future<List<DomainModel>?> getDomainList();

  Future<UserProfile?> login({required String userName, required String password});

  Future<TasksResponse?> getTasksByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter});

  Future<TasksResponse?> getPlansByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter});

  Future<List<CalendarTask>?> getAllTaskCalendar({required String? begin, required String? end});

  Future<List<PhongBan>?> getPhongBan();

  Future<List<LanhDao>?> getLanhDao();

  Future<List<CoQuan>?> getCoQuan();

  Future<List<TypeOfWork>?> getLoaiCongViec();

  Future<List<TypeOfWork>?> getLoaiCongViecKeHoach();

  Future<List<Employee>?> getEmployee();

  Future<List<Employee>?> getEmployeeByDepartment({required String phongban_id});

  Future<SubTaskListResponse?> getSubTaskList({required String congviec_id, String? statusFilter, String? tenFilter, int? page});

  Future<SubTaskProgressResponse?> getSubTaskProgress({required String chitietcongviec_id});

  Future<String?> downloadFile({required String url, required dir});

  Future createOrUpdateTask({required FormData formData, required bool isCreateNew});

  Future createOrUpdateTaskCalendar({required FormData formData, required bool isCreateNew});

  Future createOrUpdateSubTask({required FormData formData, required bool isCreateNew});

  Future deleteFileOfSubTask({required dynamic request});

  Future<CommentListResponse?> getCommentList({required num congviec_id});

  Future addComment({required num congviec_id, required num replyto, required String comment});

  Future unsentComment({required int congviec_id});

  Future reviewTaskCalendar({required int calendar_id});

  Future deleteTaskCalendar({required FormData formData});

  Future addNewReview({required FormData formData});

  Future createOrUpdateReport({required FormData formData, required bool isCreateNew});

  Future deleteReport({required FormData formData});

  Future updateTaskStatus({required FormData formData});

  Future<List<NotificationResponse>?> notificationList();

  Future updateNotificationRead({required dynamic request});

  Future<CalendarTaskResponse?> getTaskCalendarById({required FormData formData});

  Future<AllLichHenResponse?> getTasksCalendar({int? page});

  Future updateStatus({required num id});

  Future pushFirebaseToken({required String firebaseToken});

  Future deleteFirebaseToken();
}
