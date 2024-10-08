import 'package:get/get.dart';

import 'review_new_logic.dart';

class ReviewNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewNewLogic());
  }
}
