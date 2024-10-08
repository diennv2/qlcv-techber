import 'package:get/get.dart';

import 'report_detail_logic.dart';

class ReportDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportDetailLogic());
  }
}
