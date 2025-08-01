import 'package:get/get.dart';
import 'package:mobile_rhm/screens/main/calendar/calendar_logic.dart';
import 'package:mobile_rhm/screens/main/home/home_logic.dart';
import 'package:mobile_rhm/screens/main/plan/plan_logic.dart';
import 'package:mobile_rhm/screens/main/xet_duyet_lich/review_calendar_logic.dart';

import 'apps/application_logic.dart';
import 'main_page_logic.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => PlanLogic());
    Get.lazyPut(() => CalendarLogic());
    Get.lazyPut(() => ApplicationLogic());
    Get.lazyPut(() => ReviewCalendarLogic(), fenix: true);
  }
}
