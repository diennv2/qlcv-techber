import 'package:dio/dio.dart';
import 'package:mobile_rhm/core/utils/dio_error_util.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar_task_response.dart';
import 'package:mobile_rhm/data/model/response/meta/domain.dart';
import 'package:mobile_rhm/data/model/response/notification/notification.dart';
import 'package:mobile_rhm/data/model/response/task/co_quan.dart';
import 'package:mobile_rhm/data/model/response/task/commment_list.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/lanh_dao.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';
import 'package:mobile_rhm/data/model/response/task/sub_task_progress_response.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';
import 'package:mobile_rhm/data/model/response/task/task.dart';
import 'package:mobile_rhm/data/model/response/task/type_of_work.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/data/network/api/api_helper.dart';
import 'package:mobile_rhm/data/network/constants/end_points.dart';
import 'package:mobile_rhm/data/network/constants/server_status.dart';
import 'package:mobile_rhm/data/network/dio_client.dart';
import 'package:mobile_rhm/data/network/exceptions/auth_exceptions.dart';
import 'package:mobile_rhm/data/network/exceptions/network_exceptions.dart';

import '../../model/response/calendar/task_calendar.dart';

class AppApiHelper implements ApiHelper {
  final DioClient _dioClient;

  AppApiHelper(this._dioClient);

  void handleError(err) {
    if (err is DioException) {
      DioException errDetail = err;
      LogUtils.log(errDetail);
      if (errDetail.response?.statusCode == ServerStatus.ERR_401) {
        throw AuthException(message: errDetail.response?.statusMessage, statusCode: errDetail.response?.statusCode);
      }
      throw NetworkException(message: DioErrorUtil.handleError(err), statusCode: 400);
    } else {
      LogUtils.logE(message: 'Exception: ${err.toString()}');
      throw UnknownException(message: err.toString());
    }
  }

  @override
  Future<UserProfile?> login({required String userName, required String password}) async {
    try {
      var body = {'username': userName, 'password': password};
      Response response = await _dioClient.post(ApiEndpoint.AUTH_LOGIN, data: body);
      if (response.statusCode == ServerStatus.SUCCESS && response.data['status'] == 'true') {
        return UserProfile.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<DomainModel>?> getDomainList() async {
    try {
      String endPoint = ApiEndpoint.DOMAIN_URL;
      Response response = await _dioClient.get(endPoint);
      if (response.statusCode == ServerStatus.SUCCESS) {
        List<DomainModel> domains = [];
        var data = response.data;
        for (var domain in data['data']) {
          domains.add(DomainModel.fromJson(domain));
        }
        return domains;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      return null;
    }
  }

  @override
  Future<TasksResponse?> getTasksByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter}) async {
    try {
      var body = {
        "page": page ?? 1,
        "phongbanid": phongbanid ?? '',
        "statusFilter": statusFilter ?? '',
        "tenFilter": tenFilter ?? '',
        "loaiduanFilter": loaiduanFilter ?? '',
        "nguoinhanviecFilter": nguoinhanviecFilter ?? ''
      };
      Response response = await _dioClient.post(ApiEndpoint.TASK_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return TasksResponse.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }
  @override
  Future<TasksResponse?> getPlansByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter}) async {
    try {
      var body = {
        "page": page ?? 1,
        "phongbanid": phongbanid ?? '',
        "statusFilter": statusFilter ?? '',
        "tenFilter": tenFilter ?? '',
        "loaiduanFilter": loaiduanFilter ?? '',
        "nguoinhanviecFilter": nguoinhanviecFilter ?? ''
      };
      Response response = await _dioClient.post(ApiEndpoint.PLAN_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return TasksResponse.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }
  @override
  Future<List<PhongBan>?> getPhongBan() async {
    try {
      var body = {};
      List<PhongBan> res = [];
      Response response = await _dioClient.post(ApiEndpoint.PHONG_BAN_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          PhongBan pb = PhongBan.fromJson(item);
          res.add(pb);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<LanhDao>?> getLanhDao() async {
    try {
      var body = {};
      List<LanhDao> res = [];
      Response response = await _dioClient.post(ApiEndpoint.LANH_DAO_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          LanhDao pb = LanhDao.fromJson(item);
          res.add(pb);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<CoQuan>?> getCoQuan() async {
    try {
      var body = {};
      List<CoQuan> res = [];
      Response response = await _dioClient.post(ApiEndpoint.CO_QUAN_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          CoQuan pb = CoQuan.fromJson(item);
          res.add(pb);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<TypeOfWork>?> getLoaiCongViec() async {
    try {
      var body = {};
      List<TypeOfWork> res = [];
      Response response = await _dioClient.post(ApiEndpoint.LOAI_CONG_VIEC_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          TypeOfWork pb = TypeOfWork.fromJson(item);
          res.add(pb);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<TypeOfWork>?> getLoaiCongViecKeHoach() async {
    try {
      var body = {};
      List<TypeOfWork> res = [];
      Response response = await _dioClient.post(ApiEndpoint.LOAI_CONG_VIEC_PLAN_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          TypeOfWork pb = TypeOfWork.fromJson(item);
          res.add(pb);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<Employee>?> getEmployee() async {
    try {
      var body = {};
      List<Employee> res = [];
      Response response = await _dioClient.post(ApiEndpoint.EMPLOYEE_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        if (response.data != null) {
          for (var item in response.data) {
            Employee pb = Employee.fromJson(item);
            res.add(pb);
          }
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<Employee>?> getEmployeeByDepartment({required String phongban_id}) async {
    try {
      var body = {'phongban_id': phongban_id};
      List<Employee> res = [];
      Response response = await _dioClient.post(ApiEndpoint.EMPLOYEE_OF_DEP_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          Employee pb = Employee.fromJson(item);
          res.add(pb);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<SubTaskListResponse?> getSubTaskList({required String congviec_id, String? statusFilter, String? tenFilter, int? page}) async {
    try {
      var body = {'congviec_id': congviec_id, "statusFilter": statusFilter, "tenFilter": tenFilter, "page": page ?? 1};
      Response response = await _dioClient.post(ApiEndpoint.SUBTASK_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return SubTaskListResponse.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<SubTaskProgressResponse?> getSubTaskProgress({required String chitietcongviec_id}) async {
    try {
      var body = {'chitietcongviec_id': chitietcongviec_id};
      Response response = await _dioClient.post(ApiEndpoint.SUBTASK_PROGRESS_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return SubTaskProgressResponse.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<String?> downloadFile({required String url, required dir}) async {
    try {
      String fileName = url.split("/").last;
      String filePath = '$dir/$fileName';
      await _dioClient.download(url, filePath);
      return filePath;
    } catch (e) {
      return null;
    }
  }

  @override
  Future createOrUpdateTask({required FormData formData, required bool isCreateNew}) async {
    try {
      Response response = await _dioClient.post(isCreateNew ? ApiEndpoint.CREATE_TASK : ApiEndpoint.UPDATE_TASK,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future createOrUpdateSubTask({required FormData formData, required bool isCreateNew}) async {
    try {
      Response response = await _dioClient.post(isCreateNew ? ApiEndpoint.CREATE_SUB_TASK : ApiEndpoint.UPDATE_SUB_TASK,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future deleteFileOfSubTask({required request}) async {
    try {
      Response response = await _dioClient.post(ApiEndpoint.DELETE_FILE_SUB_TASK, data: request);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<CommentListResponse?> getCommentList({required num congviec_id}) async {
    try {
      var request = {'congviec_id': congviec_id};
      Response response = await _dioClient.post(ApiEndpoint.TASK_COMMENT_LIST, data: request);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return CommentListResponse.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      LogUtils.logE(message: 'getCommentList error ${err.toString()}');
      handleError(err);
    }
    return null;
  }

  @override
  Future addComment({required num congviec_id, required num replyto, required String comment}) async {
    try {
      var request = {'congviec_id': congviec_id, 'replyto': replyto, 'comment': comment};
      Response response = await _dioClient.post(ApiEndpoint.TASK_COMMENT_NEW, data: request);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      LogUtils.logE(message: 'addComment error ${err.toString()}');
      handleError(err);
    }
    return null;
  }

  @override
  Future unsentComment({required int congviec_id}) async {
    try {
      var request = {'comment_id': congviec_id};
      Response response = await _dioClient.post(ApiEndpoint.TASK_COMMENT_REVERT, data: request);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      LogUtils.logE(message: 'unsentComment error ${err.toString()}');
      handleError(err);
    }
    return null;
  }

  @override
  Future addNewReview({required FormData formData}) async {
    try {
      Response response = await _dioClient.post(ApiEndpoint.REVIEW_NEW,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future createOrUpdateReport({required FormData formData, required bool isCreateNew}) async {
    try {
      Response response = await _dioClient.post(isCreateNew ? ApiEndpoint.CREATE_REPORT : ApiEndpoint.UPDATE_REPORT,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future deleteReport({required FormData formData}) async {
    try {
      Response response = await _dioClient.post(ApiEndpoint.DELETE_REPORT,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future updateTaskStatus({required FormData formData}) async {
    try {
      Response response = await _dioClient.post(ApiEndpoint.UPDATE_TASK_STATUS,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<NotificationResponse>?> notificationList() async {
    try {
      List<NotificationResponse> res = [];
      Response response = await _dioClient.post(
        ApiEndpoint.NOTIFICATION_LIST,
      );
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          var jsonItem = NotificationResponse.fromJson(item);
          res.add(jsonItem);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future updateNotificationRead({required request}) async {
    try {
      Response response = await _dioClient.post(ApiEndpoint.UPDATE_READ_NOTIFICATION, data: request);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      LogUtils.logE(message: 'updateNotificationRead error ${err.toString()}');
      handleError(err);
    }
    return null;
  }

  @override
  Future createOrUpdateTaskCalendar({required FormData formData, required bool isCreateNew}) async {
    try {
      Response response = await _dioClient.post(isCreateNew ? ApiEndpoint.CREATE_CALENDAR : ApiEndpoint.UPDATE_CALENDAR,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future deleteTaskCalendar({required FormData formData}) async {
    try {
      Response response = await _dioClient.post(ApiEndpoint.DELETE_CALENDAR,
          data: formData,
          options: Options(
            headers: {'content-type': 'multipart/form-data'},
            contentType: 'multipart/form-data',
          ));
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future<List<CalendarTask>?> getAllTaskCalendar({String? begin, String? end}) async {
    try {
      var body = {
        "begin": begin ?? "",
        "end": end ?? '',
      };
      List<CalendarTask> res = [];
      Response response = await _dioClient.post(ApiEndpoint.CALENDAR_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        for (var item in response.data) {
          CalendarTask pb = CalendarTask.fromJson(item);
          res.add(pb);
        }
        return res;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future reviewTaskCalendar({required int calendar_id}) async {
    try {
      var request = {'calendar_id': calendar_id};
      Response response = await _dioClient.post(ApiEndpoint.CALENDAR_REVIEW, data: request);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      LogUtils.logE(message: 'addComment error ${err.toString()}');
      handleError(err);
    }
    return null;
  }

  @override
  Future<CalendarTaskResponse?> getTaskCalendarById({required FormData formData}) async {
    try {
      // Gửi yêu cầu POST với formData
      Response response = await _dioClient.post(ApiEndpoint.DETAIL_CANLENDAR_TASK, data: formData);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return CalendarTaskResponse.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      LogUtils.logE(message: 'getTaskCalendar error ${err.toString()}');
      handleError(err);
    }
    return null;
  }

  @override
  Future<AllLichHenResponse?> getTasksCalendar(
      {int? page}) async {
    try {
      var body = {
        "page": page ?? 1,
      };
      Response response = await _dioClient.post(ApiEndpoint.APPOINTMEN_LIST, data: body);
      if (response.statusCode == ServerStatus.SUCCESS) {
        return AllLichHenResponse.fromJson(response.data);
      }
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      handleError(err);
    }
    return null;
  }

  @override
  Future updateStatus({required num id}) async {
    try {
      // Tạo FormData với tham số id và nguoiduyet
      var formData = FormData.fromMap({
        'id': id,
      });

      // Gửi yêu cầu POST với FormData và header multipart/form-data
      Response response = await _dioClient.post(
        ApiEndpoint.CALENDAR_UPDATE_STATUS,
        data: formData,
        options: Options(
          headers: {'content-type': 'multipart/form-data'},
          contentType: 'multipart/form-data',
        ),
      );

      // Kiểm tra mã phản hồi từ server
      if (response.statusCode == ServerStatus.SUCCESS) {
        return response.data;
      }

      // Nếu phản hồi không thành công, ném ra ngoại lệ
      throw NetworkException(message: response.statusMessage, statusCode: response.statusCode);
    } catch (err) {
      // Xử lý lỗi
      LogUtils.logE(message: 'updateStatusCalendar error ${err.toString()}');
      handleError(err);
    }

    return null;
  }

}
