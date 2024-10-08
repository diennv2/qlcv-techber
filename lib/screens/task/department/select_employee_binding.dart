import 'package:get/get.dart';

import 'select_employee_logic.dart';

class SelectEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectEmployeeLogic());
  }
}
