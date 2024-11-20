import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/app_widgets/date_timer_picker.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/app_widgets/warning_view.dart';
import 'package:mobile_rhm/core/constants/file_type.dart';
import 'package:mobile_rhm/core/constants/qltc.dart';
import 'package:mobile_rhm/core/constants/roles.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/constants/task_important.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/dialog_utils.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/utils/navigation_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/nguoi_nhan_viec.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import '../../../app_widgets/date_time_picker2.dart';
import 'create_new_calendar_state.dart';

class CreateNewCalendarLogic extends GetxController {
  final CreateNewCalendarState state = CreateNewCalendarState();
  final RHMService _rhmService = Get.find<RHMService>();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskInfoController = TextEditingController();

  final GroupButtonController groupLanhDaoController = GroupButtonController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initData();
  }

  DateTime? _convertTime({String? timeInString, String? formatDate}) {
    DateFormat format = DateFormat(formatDate ?? 'dd/MM/yyyy');
    try {
      DateTime date = format.parse(timeInString!);
      return date;
    } catch (e) {
      return null;
    }
  }

  _initData() {
    //TODO: init cause Update
    if (state.task != null) {
      taskNameController.text = state.task?.tencongviec ?? '';
      taskInfoController.text = state.task?.chitiet ?? '';
    }

    taskNameController.addListener(() {
      state.errorTaskName.value = '';
    });

    _rhmService.metadataService.getLanhDao().then((value) {
      if (value != null) {
        state.lanhDaos.value = value.map((e) => OptionModel(key: '${e.id}', value: e.ten ?? '')).toList();

        //TODO: Init lanh dao selected
        if (state.task != null) {
          final lanhdao = state.task?.lanhdao; // Lấy giá trị lanhdao (nếu là num)

          if (lanhdao != null) {
            // Tạo OptionModel từ lanhdao (kiểu num)
            state.selectedLanhDaos.add(OptionModel(key: '$lanhdao', value: '$lanhdao'));

            // Tìm và chọn lanhdao từ danh sách lanhDaos
            int index = state.lanhDaos.indexWhere((ld) => ld.key == '$lanhdao');
            if (index != -1) {
              groupLanhDaoController.selectIndex(index);
            }
          }
        }
      }
    });

    state.statusOfWorks.value = TaskStatus.TASK_CREATE_FILTER;
    state.typeOfFinances.value = FinanceTask.TASK_FILTER;
    state.typeOfImportants.value = ImportantTask.TASK_FILTER;


    //TODO: init start time and endtime
    if (state.task != null) {
      String? startTime = state.task?.starttime;
      if (startTime.isNotNullOrBlank) {
        LogUtils.logE(message: 'Start date $startTime');
        DateTime? date = _convertTime(timeInString: startTime);
        if (date != null) {
          state.selectedStartDateTime.value = date;
          state.dateTimeStartValue.value = startTime!;
        }
      }

      String? endTime = state.task?.endtime;
      if (endTime.isNotNullOrBlank) {
        LogUtils.logE(message: 'End date $endTime');
        DateTime? date = _convertTime(timeInString: endTime, formatDate: 'yyyy-MM-dd');
        if (date != null) {
          DateFormat originalFormat = DateFormat('dd/MM/yyyy');
          state.selectedEndDateTime.value = date;
          state.dateTimeEndValue.value = originalFormat.format(date);
        }
      }
    }

    //TODO: Check CRUD
    if (state.task == null) {
      state.isAllowCRUD.value = true;
    } else {
      UserProfile? user = _rhmService.userService.getUserProfile();
      if (user?.displayName?.toLowerCase() == UserRole.SUPER_ADMIN.toLowerCase() || user?.userId == state.task?.owner) {
        state.isAllowCRUD.value = true;
      }
    }
  }

  void updateEmployee(RxMap<String, List<Employee>> staffs, Nguoinhanviec updatedEmployee) {
    bool employeeUpdated = false;

    // Duyệt qua tất cả các key trong RxMap
    staffs.forEach((key, employees) {
      // Tìm index của nhân viên cần cập nhật dựa trên id
      int index = employees.indexWhere((employee) => employee.id == updatedEmployee.id);

      if (index != -1) {
        // Thay thế nhân viên cũ bằng nhân viên đã cập nhật
        employees[index].taskRole.value = updatedEmployee.enumType == TaskRole.PRIMARY ? 0 : 1;

        // Cập nhật lại danh sách trong map
        staffs[key] = List<Employee>.from(employees);
        employeeUpdated = true;
      }
    });

    if (!employeeUpdated) {
      print('Employee with id ${updatedEmployee.id} not found');
    }
  }

  void selectTaskStartTime() async {
    Widget datetimePick = DateTimePicker2(
      onSelect: (DateTime date) {
        LogUtils.logE(message: 'Select date time');
        state.selectedStartDateTime.value = date;
        state.dateTimeStartValue.value = '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
        state.errorStartTime.value = '';
      },
      initDate: state.selectedStartDateTime.value,
      title: AppStrings.task_start_time.tr,
    );
    await Get.bottomSheet(datetimePick);
  }

  void selectTaskEndTime() async {
    Widget datetimePick = DateTimePicker2(
      onSelect: (DateTime date) {
        LogUtils.logE(message: 'Select date time');
        state.selectedEndDateTime.value = date;
        state.dateTimeEndValue.value = '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
      },
      initDate: state.dateTimeStartValue.value.isNotNullOrBlank ? state.selectedStartDateTime.value : state.selectedStartDateTime.value,
      title: AppStrings.task_end_time.tr,
    );
    await Get.bottomSheet(datetimePick);
  }

  void clearFile(PlatformFile file) {
    state.attachFiles.remove(file);
    state.attachFiles.refresh();
  }

  void createNewOrUpdateTask() {
    bool isValid = isFormValid();
    if (isValid) {
      confirmSubmitTask();
    } else {
      _rhmService.toastService.showToast(message: AppStrings.form_invalid_error.tr, isSuccess: false, context: Get.context!);
    }
  }

  bool isFormValid() {
    String taskName = taskNameController.text;
    if (taskName.isNullOrEmpty) {
      state.errorTaskName.value = AppStrings.required_field.tr;
      return false;
    }

    if (state.dateTimeStartValue.value.isNullOrEmpty) {
      state.errorStartTime.value = AppStrings.required_field.tr;
      return false;
    }

    if (state.dateTimeEndValue.value.isNotNullOrBlank) {
      if (state.selectedEndDateTime.value.millisecondsSinceEpoch < state.selectedStartDateTime.value.millisecondsSinceEpoch) {
        state.errorStartTime.value = AppStrings.invalid_start_date.tr;
        return false;
      }
    }
    return true;
  }

  Map<String, String> _createStaffRequest() {
    Map<String, String> staffMap = {};
    state.staffs.forEach((key, employeeList) {
      for (Employee employee in employeeList) {
        if (employee.taskRole.value >= 0) {
          String key = 'nhanvieninput[${employee.id}]';
          String value = employee.taskRole.value == 0 ? TaskRole.PRIMARY : TaskRole.SECOND_PRIMARY;
          staffMap[key] = value;
        }
      }
    });
    return staffMap;
  }

  List<num> _createPhongBanRequest() {
    List<Employee> staffs = [];

    // Thu thập tất cả các nhân viên có taskRole.value >= 0
    state.staffs.forEach((key, employeeList) {
      for (Employee employee in employeeList) {
        if (employee.taskRole.value >= 0) {
          staffs.add(employee);
        }
      }
    });

    // Chuyển đổi danh sách nhân viên thành danh sách phongbanId duy nhất
    Set<num> phongBans = staffs.map((e) => e.phongbanId!).toSet();

    return phongBans.toList();
  }

  Future<List<Dio.MultipartFile>> _createFiles() async {
    List<Dio.MultipartFile> files = [];
    if (state.attachFiles.isNotEmpty) {
      for (var file in state.attachFiles.value) {
        LogUtils.logE(message: 'XFile Path is ${file.xFile.path}');
        var mul = await Dio.MultipartFile.fromFile(file.xFile.path, filename: file.name);
        files.add(mul);
      }
    }
    return files;
  }

  void _submitTask() async {
    try {
      DialogUtils.showLoading();
      // Include hours and minutes in the DateFormat
      DateFormat originalFormat = DateFormat('dd/MM/yyyy HH:mm');
      DateFormat newFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

      var request = {
        'Calendar[tencongviec]': taskNameController.text,
        'Calendar[chitiet]': taskInfoController.text,
        'Calendar[lanhdao]': state.selectedLanhDaos.map((option) => option.key).toList(),
        'Calendar[starttime]': state.dateTimeStartValue.value.isNotNullOrBlank
            ? newFormat.format(originalFormat.parse(state.dateTimeStartValue.value))
            : '',
        'Calendar[endtime]': state.dateTimeEndValue.value.isNotNullOrBlank
            ? newFormat.format(originalFormat.parse(state.dateTimeEndValue.value))
            : '',
      };

      if (state.task != null) {
        request['id'] = state.task!.id!;
      }

      bool isCreateNew = state.task == null;

      LogUtils.log(request);
      Dio.FormData formData = Dio.FormData.fromMap(request);
      var res = await _rhmService.calendarService.createOrUpdateTask(data: formData, isCreateNew: isCreateNew);
      DialogUtils.hideLoading();

      if (res != null && res['status'] == true) {
        _rhmService.toastService.showToast(
          message: state.task != null ? AppStrings.update_task_success.tr : AppStrings.create_new_task_success.tr,
          isSuccess: true,
          context: Get.context!,
        );
        NavigationUtils.popUtils(page: Routers.MAIN);
      } else {
        _rhmService.toastService.showToast(
          message: res['message'] ?? AppStrings.error_common.tr,
          isSuccess: false,
          context: Get.context!,
        );
      }
    } catch (e) {
      DialogUtils.hideLoading();
      _rhmService.toastService.showToast(
        message: AppStrings.error_common.tr,
        isSuccess: false,
        context: Get.context!,
      );
    }
  }


  void confirmSubmitTask() {
    Widget confirmSendView = WarningView(
        icon: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: ImageDisplay(
            Assets.ic_complete_test,
            width: 116.w,
          ),
        ),
        title: AppStrings.form_task_complete.tr,
        descriptions: AppStrings.form_task_complete_confirm.tr,
        positiveText: AppStrings.btn_send.tr,
        negativeText: AppStrings.btn_cancel.tr,
        onPositive: () {
          _submitTask();
        });
    DialogUtils.showCenterDialog(child: confirmSendView);
  }

  void selectLanhDao(OptionModel selected) {
    // Deselect all previous selections and add the new selection
    state.selectedLanhDaos.clear();
    state.selectedLanhDaos.add(selected);

    // Update the group button controller to reflect the new selection
    groupLanhDaoController.selectIndex(state.lanhDaos.indexOf(selected));
  }

}
