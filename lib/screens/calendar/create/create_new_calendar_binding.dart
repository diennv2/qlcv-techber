import 'package:get/get.dart';

import 'create_new_calendar_logic.dart';

class CreateNewCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateNewCalendarLogic());
  }
}
