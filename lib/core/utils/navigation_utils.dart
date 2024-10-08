import 'package:get/get.dart';

class NavigationUtils {
  static void popUtils({required String page}) {
    Get.until((route) {
      return Get.currentRoute == page;
    });
  }
}
