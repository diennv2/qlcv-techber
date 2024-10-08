import 'package:get/get.dart';

import 'create_sub_task_logic.dart';

class CreateSubTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateSubTaskLogic());
  }
}
