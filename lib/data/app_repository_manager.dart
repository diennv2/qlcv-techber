import 'package:dio/src/form_data.dart';
import 'package:mobile_rhm/data/local/database_helper.dart';
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
import 'package:mobile_rhm/data/repository_manager.dart';

import 'model/response/calendar/task_calendar.dart';
import 'prefs/preference_helper.dart';

class AppRepositoryManager extends RepositoryManager {
  final DatabaseHelper _databaseHelper;
  final PreferenceHelper _preferenceHelper;
  final ApiHelper _apiHelper;

  AppRepositoryManager(this._databaseHelper, this._preferenceHelper, this._apiHelper);

  @override
  String? authToken() {
    return _preferenceHelper.authToken();
  }

  @override
  Future<bool> saveAuthToken(String authToken) {
    return _preferenceHelper.saveAuthToken(authToken);
  }

  @override
  Future<UserProfile?> login({required String userName, required String password}) {
    return _apiHelper.login(userName: userName, password: password);
  }

  @override
  UserProfile? getUserProfile() {
    return _databaseHelper.getUserProfile();
  }

  @override
  void saveUserProfile({required UserProfile profile}) {
    _databaseHelper.saveUserProfile(profile: profile);
  }

  @override
  bool isRememberLogin() {
    return _preferenceHelper.isRememberLogin();
  }

  @override
  void setRememberLogin({required bool isRemember}) {
    _preferenceHelper.setRememberLogin(isRemember: isRemember);
  }

  @override
  String? refreshToken() {
    return _preferenceHelper.refreshToken();
  }

  @override
  Future<bool> saveRefreshToken(String refreshToken) {
    return _preferenceHelper.saveRefreshToken(refreshToken);
  }

  @override
  Future<List<DomainModel>?> getDomainList() {
    return _apiHelper.getDomainList();
  }

  @override
  List<DomainModel>? getLocalDomains() {
    return _databaseHelper.getLocalDomains();
  }

  @override
  void saveDomains({required List<DomainModel> domains}) {
    _databaseHelper.saveDomains(domains: domains);
  }

  @override
  String? currentDomainUrl() {
    return _preferenceHelper.currentDomainUrl();
  }

  @override
  Future<bool> saveCurrentDomainUrl(String url) {
    return _preferenceHelper.saveCurrentDomainUrl(url);
  }

  @override
  Future<TasksResponse?> getTasksByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter}) {
    return _apiHelper.getTasksByFilter(
        page: page,
        phongbanid: phongbanid,
        statusFilter: statusFilter,
        tenFilter: tenFilter,
        loaiduanFilter: loaiduanFilter,
        nguoinhanviecFilter: nguoinhanviecFilter);
  }

  @override
  Future<TasksResponse?> getPlansByFilter(
      {int? page, String? phongbanid, String? statusFilter, String? tenFilter, String? loaiduanFilter, String? nguoinhanviecFilter}) {
    return _apiHelper.getPlansByFilter(
        page: page,
        phongbanid: phongbanid,
        statusFilter: statusFilter,
        tenFilter: tenFilter,
        loaiduanFilter: loaiduanFilter,
        nguoinhanviecFilter: nguoinhanviecFilter);
  }

  @override
  Future<List<PhongBan>?> getPhongBan() {
    return _apiHelper.getPhongBan();
  }

  @override
  Future<List<LanhDao>?> getLanhDao() {
    return _apiHelper.getLanhDao();
  }

  @override
  Future<List<CoQuan>?> getCoQuan() {
    return _apiHelper.getCoQuan();
  }

  @override
  Future<List<TypeOfWork>?> getLoaiCongViec() {
    return _apiHelper.getLoaiCongViec();
  }

  @override
  Future<List<TypeOfWork>?> getLoaiCongViecKeHoach() {
    return _apiHelper.getLoaiCongViecKeHoach();
  }

  @override
  Future<List<Employee>?> getEmployee() {
    return _apiHelper.getEmployee();
  }

  @override
  Future<List<Employee>?> getEmployeeByDepartment({required String phongban_id}) {
    return _apiHelper.getEmployeeByDepartment(phongban_id: phongban_id);
  }

  @override
  Future<SubTaskListResponse?> getSubTaskList({required String congviec_id, String? statusFilter, String? tenFilter, int? page}) {
    return _apiHelper.getSubTaskList(congviec_id: congviec_id, statusFilter: statusFilter, tenFilter: tenFilter, page: page);
  }

  @override
  Future<SubTaskProgressResponse?> getSubTaskProgress({required String chitietcongviec_id}) {
    return _apiHelper.getSubTaskProgress(chitietcongviec_id: chitietcongviec_id);
  }

  @override
  Future<String?> downloadFile({required String url, required dir}) {
    return _apiHelper.downloadFile(url: url, dir: dir);
  }

  @override
  Future createOrUpdateTask({required FormData formData, required bool isCreateNew}) {
    return _apiHelper.createOrUpdateTask(formData: formData, isCreateNew: isCreateNew);
  }

  @override
  Future createOrUpdateSubTask({required FormData formData, required bool isCreateNew}) {
    return _apiHelper.createOrUpdateSubTask(formData: formData, isCreateNew: isCreateNew);
  }

  @override
  Future deleteFileOfSubTask({required request}) {
    return _apiHelper.deleteFileOfSubTask(request: request);
  }

  @override
  Future<CommentListResponse?> getCommentList({required num congviec_id}) {
    return _apiHelper.getCommentList(congviec_id: congviec_id);
  }

  @override
  Future addComment({required num congviec_id, required num replyto, required String comment}) {
    return _apiHelper.addComment(congviec_id: congviec_id, replyto: replyto, comment: comment);
  }

  @override
  Future unsentComment({required int congviec_id}) {
    return _apiHelper.unsentComment(congviec_id: congviec_id);
  }

  @override
  Future addNewReview({required FormData formData}) {
    return _apiHelper.addNewReview(formData: formData);
  }

  @override
  Future createOrUpdateReport({required FormData formData, required bool isCreateNew}) {
    return _apiHelper.createOrUpdateReport(formData: formData, isCreateNew: isCreateNew);
  }

  @override
  Future deleteReport({required FormData formData}) {
    return _apiHelper.deleteReport(formData: formData);
  }

  @override
  Future updateTaskStatus({required FormData formData}) {
   return _apiHelper.updateTaskStatus(formData: formData);
  }

  @override
  Future<List<NotificationResponse>?> notificationList() {
    return _apiHelper.notificationList();
  }

  @override
  Future updateNotificationRead({required request}) {
    return _apiHelper.updateNotificationRead(request: request);
  }

  @override
  Future createOrUpdateTaskCalendar({required FormData formData, required bool isCreateNew}) {
    return _apiHelper.createOrUpdateTaskCalendar(formData: formData, isCreateNew: isCreateNew);
  }

  @override
  Future deleteTaskCalendar({required FormData formData}) {
    return _apiHelper.deleteTaskCalendar(formData: formData);
  }

  @override
  Future<List<CalendarTask>?> getAllTaskCalendar({String? begin, String? end}) {
    return _apiHelper.getAllTaskCalendar(begin: begin, end: end);
  }

  @override
  Future reviewTaskCalendar({required int calendar_id}) {
    return _apiHelper.reviewTaskCalendar(calendar_id: calendar_id);
  }

  @override
  Future<CalendarTaskResponse?> getTaskCalendarById({required FormData formData,}) {
    return _apiHelper.getTaskCalendarById(formData: formData);
  }

  @override
  Future<AllLichHenResponse?> getTasksCalendar({int? page}) {
    return _apiHelper.getTasksCalendar(page: page);
  }

  @override
  Future updateStatus({required num id}) {
    return _apiHelper.updateStatus(id: id);
  }
}
