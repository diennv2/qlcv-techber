import 'package:get/get.dart';

import 'report_new_logic.dart';

class ReportNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportNewLogic());
  }
}
