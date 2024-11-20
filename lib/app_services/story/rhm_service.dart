import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/bus_service.dart';
import 'package:mobile_rhm/app_services/meta/metadata_service.dart';
import 'package:mobile_rhm/app_services/story/calendar/calendar_service.dart';
import 'package:mobile_rhm/app_services/story/tasks/task_service.dart';
import 'package:mobile_rhm/core/utils/toast_utils.dart';

import 'auth/authen_service.dart';
import 'user/user_service.dart';

class RHMService extends GetxService {
  final ToastService toastService = Get.find<ToastService>();
  final MetadataService metadataService = Get.find<MetadataService>();
  final AuthenService authenService = Get.find<AuthenService>();
  final UserService userService = Get.find<UserService>();
  final TaskService taskService = Get.find<TaskService>();
  final EventBusService eventBusService = Get.find<EventBusService>();
  final CalendarService calendarService = Get.find<CalendarService>();
}
