import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/task/co_quan.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';
import 'package:mobile_rhm/data/model/response/task/sub_task_progress_response.dart';

class CreateSubTaskState {
  SubTaskProgressResponse? task;
  String? rootTaskName;
  RxString errorTaskName = ''.obs;
  RxString taskType = ''.obs;
  RxString errorStartTime = ''.obs;

  RxList<OptionModel> statusOfWorks = <OptionModel>[].obs;

  Rx<DateTime> selectedStartDateTime = DateTime.now().obs;
  Rx<DateTime> selectedEndDateTime = DateTime.now().obs;
  RxString dateTimeStartValue = ''.obs;
  RxString dateTimeEndValue = ''.obs;
  RxString coQuanSelect = ''.obs;
  RxString coQuanValue = ''.obs;

  RxList<PlatformFile> attachFiles = <PlatformFile>[].obs;

  RxMap<String, List<Employee>> staffs = <String, List<Employee>>{}.obs;
  RxList<PhongBan> phongBans = <PhongBan>[].obs;
  RxList<CoQuan> coQuan = <CoQuan>[].obs;

  OptionModel? selectedStatusOfWork;
  RxBool isAllowCRUD = false.obs;

  int taskId = Get.arguments[AppExtraData.ID];

  CreateSubTaskState() {
    if (Get.arguments != null) {
      task = Get.arguments[AppExtraData.DATA];
      rootTaskName = Get.arguments[AppExtraData.TEXT];
    }
  }
}
