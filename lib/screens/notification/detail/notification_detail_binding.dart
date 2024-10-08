import 'package:get/get.dart';

import 'notification_detail_logic.dart';

class NotificationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationDetailLogic());
  }
}
