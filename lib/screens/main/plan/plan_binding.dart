import 'package:get/get.dart';

import 'plan_logic.dart';

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlanLogic());
  }
}
