import 'package:get/get.dart';

import 'create_new_plan_logic.dart';

class CreateNewPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateNewPlanLogic());
  }
}
