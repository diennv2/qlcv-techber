import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/data/model/response/calendar/calendar_task_response.dart';

import '../../../data/model/common/opttion_model.dart';

class CalendarDetailState {
  Rx<CalendarTaskDetail?> task = Rx<CalendarTaskDetail?>(null);
  RxBool isEditing = false.obs;
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController lanhdaoNameController = TextEditingController();
  final TextEditingController chitietController = TextEditingController();
  final TextEditingController ghiChuController = TextEditingController();
  //For update task

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

  List<OptionModel> selectedLanhDaos = [];

  RxBool isAllowCRUD = false.obs;

  CreateNewTaskState() {
    ///Initialize variables
  }
}
