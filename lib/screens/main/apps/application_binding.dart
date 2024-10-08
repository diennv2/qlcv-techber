import 'package:get/get.dart';

import 'application_logic.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplicationLogic());
  }
}
