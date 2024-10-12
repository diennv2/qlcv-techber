part of './app_pages.dart';

class Routers {
  static const SPLASH_SCREEN = '/splash_screen';

  //Authentication
  static const AUTH_LOGIN = '/login_screen';
  static const AUTH_FPASS_INPUT_EMAIL = '/forget_password_input_email';
  static const AUTH_FPASS_INPUT_CODE = '/forget_password_input_code';
  static const AUTH_FPASS_INPUT_NEWPASS = '/forget_password_input_new_pass';

  static const MAIN = '/main_screen';

  //Notification
  static const NOTIFICATION_LIST = '/notification_list';
  static const NOTIFICATION_DETAIL = '/notification_detail';

  //Task detail
  static const TASK_DETAIL = '/task_detail';
  static const TASK_NEW = '/task_new';
  static const TASK_SELECT_STAFF = '/select_staff';

  //Task detail
  static const PLAN_NEW = '/plan_new';


  //Sub Task
  static const SUB_TASK_NEW = '/sub_task_new';

  //Report
  static const REPORT_NEW = '/report_new';
  static const REPORT_DETAIL = '/report_detail';
  static const REVIEW_NEW = '/review_new';
}
