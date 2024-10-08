import 'package:get/get.dart';

import 'task_detail_logic.dart';

class TaskDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskDetailLogic(), fenix: true);
  }
}
