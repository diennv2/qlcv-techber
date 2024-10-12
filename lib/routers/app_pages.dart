import 'package:get/get.dart';
import 'package:mobile_rhm/screens/auth/signin/signin_binding.dart';
import 'package:mobile_rhm/screens/auth/signin/signin_view.dart';
import 'package:mobile_rhm/screens/common/splash/splash_binding.dart';
import 'package:mobile_rhm/screens/common/splash/splash_view.dart';
import 'package:mobile_rhm/screens/main/main_page_binding.dart';
import 'package:mobile_rhm/screens/main/main_page_view.dart';
import 'package:mobile_rhm/screens/notification/detail/notification_detail_binding.dart';
import 'package:mobile_rhm/screens/notification/detail/notification_detail_view.dart';
import 'package:mobile_rhm/screens/notification/list/notification_list_binding.dart';
import 'package:mobile_rhm/screens/notification/list/notification_list_view.dart';
import 'package:mobile_rhm/screens/report/detail/report_detail_binding.dart';
import 'package:mobile_rhm/screens/report/detail/report_detail_view.dart';
import 'package:mobile_rhm/screens/report/new/report_new_binding.dart';
import 'package:mobile_rhm/screens/report/new/report_new_view.dart';
import 'package:mobile_rhm/screens/report/review/review_new_binding.dart';
import 'package:mobile_rhm/screens/report/review/review_new_view.dart';
import 'package:mobile_rhm/screens/subtask/create_sub_task_binding.dart';
import 'package:mobile_rhm/screens/subtask/create_sub_task_view.dart';
import 'package:mobile_rhm/screens/task/create/create_new_task_binding.dart';
import 'package:mobile_rhm/screens/task/create/create_new_task_view.dart';
import 'package:mobile_rhm/screens/task/createplan/create_new_plan_binding.dart';
import 'package:mobile_rhm/screens/task/createplan/create_new_plan_view.dart';
import 'package:mobile_rhm/screens/task/department/select_employee_binding.dart';
import 'package:mobile_rhm/screens/task/department/select_employee_view.dart';
import 'package:mobile_rhm/screens/task/detail/task_detail_binding.dart';
import 'package:mobile_rhm/screens/task/detail/task_detail_view.dart';

part 'app_routers.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routers.SPLASH_SCREEN, page: () => SplashPage(), binding: SplashBinding()),
    //Auth
    GetPage(name: Routers.AUTH_LOGIN, page: () => const SigninPage(), binding: SigninBinding()),

    //Main
    GetPage(name: Routers.MAIN, page: () => const MainPagePage(), binding: MainPageBinding()),

    //Notification
    GetPage(name: Routers.NOTIFICATION_LIST, page: () => NotificationListPage(), binding: NotificationListBinding()),
    GetPage(name: Routers.NOTIFICATION_DETAIL, page: () => NotificationDetailPage(), binding: NotificationDetailBinding()),

    //Task
    GetPage(name: Routers.TASK_DETAIL, page: () => TaskDetailPage(), binding: TaskDetailBinding()),
    GetPage(name: Routers.TASK_NEW, page: () => CreateNewTaskPage(), binding: CreateNewTaskBinding()),
    GetPage(name: Routers.TASK_SELECT_STAFF, page: () => SelectEmployeePage(), binding: SelectEmployeeBinding()),

    //Plan
    GetPage(name: Routers.PLAN_NEW, page: () => CreateNewPlanPage(), binding: CreateNewPlanBinding()),
    //SubTask
    GetPage(name: Routers.SUB_TASK_NEW, page: () => CreateSubTaskPage(), binding: CreateSubTaskBinding()),

    //Report
    GetPage(name: Routers.REPORT_NEW, page: () => ReportNewPage(), binding: ReportNewBinding()),
    GetPage(name: Routers.REPORT_DETAIL, page: () => ReportDetailPage(), binding: ReportDetailBinding()),
    GetPage(name: Routers.REVIEW_NEW, page: () => ReviewNewPage(), binding: ReviewNewBinding()),
  ];
}
