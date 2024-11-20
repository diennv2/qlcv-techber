import 'package:get/get.dart';

import 'review_calendar_logic.dart';

class ReviewCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewCalendarLogic());
  }
}
