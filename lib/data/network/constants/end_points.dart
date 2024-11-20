class ApiEndpoint {
  ApiEndpoint._();

  //Define all endpoint here
  static const String DOMAIN_URL = "https://techber.vn/qlcv.json";

  //AUTH
  static const String AUTH_LOGIN = "@domain/api-login.html";
  static const String AUTH_CHANGE_PASS = "@domain/auth/change-password";
  static const String AUTH_FORGET_PASS = "@domain/auth/forget-password";
  static const String REFRESH_TOKEN_URL = "@domain/refresh-token.html";

  //Task
  static const String TASK_LIST = "@domain/api/getall_task.html";
  static const String PHONG_BAN_LIST = "@domain/api/getall_phongban.html";
  static const String LOAI_CONG_VIEC_LIST = "@domain/api/getall_loaicongviec.html";
  static const String LANH_DAO_LIST = "@domain/api/getall_lanhdao.html";
  static const String CO_QUAN_LIST = "@domain/api/getall_coquan.html";
  static const String EMPLOYEE_LIST = "@domain/api/getall_user.html";
  static const String EMPLOYEE_OF_DEP_LIST = "@domain/api/getnhanvien_phongban.html";
  static const String SUBTASK_LIST = "@domain/api/getcongviec_listjob.html";
  static const String SUBTASK_PROGRESS_LIST = "@domain/api/getcongviec_jobdetails.html";
  static const String CREATE_TASK = "@domain/api/congviec_create.html";
  static const String UPDATE_TASK = "@domain/api/congviec_update.html";
  static const String CREATE_SUB_TASK = "@domain/api/jobdetails_create.html";
  static const String UPDATE_SUB_TASK = "@domain/api/jobdetails_update.html";
  static const String DELETE_FILE_SUB_TASK = "@domain/api/jobdetails_deletefile.html";
  static const String UPDATE_TASK_STATUS = "@domain/api/congviec_update_status.html";

  static const String PLAN_LIST = "@domain/api/getall_task_kehoach.html";
  static const String LOAI_CONG_VIEC_PLAN_LIST = "@domain/api/getall_loaicongviec_kehoach.html";
  //Comment
  static const String TASK_COMMENT_LIST = "@domain/api/congviec_getall_comment.html";
  static const String TASK_COMMENT_NEW = "@domain/api/congviec_comment.html";
  static const String TASK_COMMENT_REVERT = "@domain/api/congviec_thuhoicomment.html";

  //Review
  static const String REVIEW_NEW = "@domain/api/jobdetails_baocao_addnew_danhgia.html";

  //Report
  static const String CREATE_REPORT = "@domain/api/jobdetails_addnew_baocao.html";
  static const String UPDATE_REPORT = "@domain/api/jobdetails_update_baocao.html";
  static const String DELETE_REPORT = "@domain/api/jobdetails_delete_baocao.html";

  //Notification
  static const String NOTIFICATION_LIST = "@domain/api/get_notification.html";
  static const String UPDATE_READ_NOTIFICATION = "@domain/api/set_notification.html";
  static const String PUSH_FIREBASE_TOKEN = "@domain/api/setdevicetoken.html";
  static const String DELETE_FIREBASE_TOKEN = "@domain/api/deletetoken.html";

  //Calendar
  static const String CALENDAR_LIST = "@domain/api/getall_calendar.html";
  static const String DETAIL_CANLENDAR_TASK = "@domain/api/view_calendar.html";
  static const String CREATE_CALENDAR = "@domain/api/add_calendar.html";
  static const String UPDATE_CALENDAR = "@domain/api/update_calendar.html";
  static const String DELETE_CALENDAR = "@domain/api/delete_calendar.html";
  static const String APPOINTMEN_LIST = "@domain/api/getall_lichhen.html";
  static const String CALENDAR_REVIEW = "@domain/api/calendar_duyet.html";
  static const String CALENDAR_UPDATE_STATUS = "@domain/api/updatecalendar_status.html";

}

class ApiMapPermission {

}
