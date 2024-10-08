import 'package:get/get.dart';

import 'notification_list_logic.dart';

class NotificationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationListLogic());
  }
}
