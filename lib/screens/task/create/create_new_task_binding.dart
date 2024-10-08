import 'package:get/get.dart';

import 'create_new_task_logic.dart';

class CreateNewTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateNewTaskLogic());
  }
}
