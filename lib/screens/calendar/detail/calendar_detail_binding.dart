import 'package:get/get.dart';

import 'calendar_detail_logic.dart';

class CalendarDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarDetailLogic(), fenix: true);
  }
}
