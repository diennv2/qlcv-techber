import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar_task_response.dart';
import 'package:mobile_rhm/data/model/response/calendar/task_calendar.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';
import 'package:mobile_rhm/data/model/response/task/task.dart';

class CreateNewCalendarState {
  // For update task
  CalendarTaskDetail? task;

  RxString errorTaskName = ''.obs;
  RxString taskType = ''.obs;
  RxString errorStartTime = ''.obs;

  RxList<OptionModel> lanhDaos = <OptionModel>[].obs;
  RxList<OptionModel> typeOfWorks = <OptionModel>[].obs;
  RxList<OptionModel> typeOfImportants = <OptionModel>[].obs;
  RxList<OptionModel> typeOfFinances = <OptionModel>[].obs;
  RxList<OptionModel> statusOfWorks = <OptionModel>[].obs;

  Rx<DateTime> selectedStartDateTime = DateTime.now().obs;
  Rx<DateTime> selectedEndDateTime = DateTime.now().obs;
  RxString dateTimeStartValue = ''.obs;
  RxString dateTimeEndValue = ''.obs;

  RxList<PlatformFile> attachFiles = <PlatformFile>[].obs;

  RxMap<String, List<Employee>> staffs = <String, List<Employee>>{}.obs;
  RxList<PhongBan> phongBans = <PhongBan>[].obs;

  List<OptionModel> selectedLanhDaos = [];

  RxBool isAllowCRUD = false.obs;

  CreateNewCalendarState() {
    // Kiểm tra Get.arguments nếu nó là TaskCalendarDetail
    var arguments = Get.arguments;

    if (arguments is CalendarTaskDetail) {
      task = arguments; // Gán đối tượng TaskCalendarDetail
    } else {
      print('Lỗi: Get.arguments không phải là TaskCalendarDetail');
    }
  }

}
