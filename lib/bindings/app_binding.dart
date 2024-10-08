import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/bus_service.dart';
import 'package:mobile_rhm/app_services/connectivity_service.dart';
import 'package:mobile_rhm/app_services/meta/metadata_service.dart';
import 'package:mobile_rhm/app_services/story/auth/authen_service.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/app_services/story/user/user_service.dart';

import '../app_services/story/tasks/task_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectService();
  }

  void injectService() {
    Get.put(ConnectivityService());
    Get.lazyPut(() => MetadataService());
    Get.lazyPut(() => AuthenService());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => EventBusService());
    Get.lazyPut(() => TaskService());
    Get.lazyPut(() => RHMService());
  }
}
