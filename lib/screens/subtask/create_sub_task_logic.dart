import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:mobile_rhm/app_services/story/permisson/permisson_list.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/app_widgets/date_timer_picker.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/app_widgets/warning_view.dart';
import 'package:mobile_rhm/core/constants/file_type.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/utils/dialog_utils.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/utils/navigation_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/task/employee.dart';
import 'package:mobile_rhm/data/model/response/task/nguoi_phoi_hop.dart';
import 'package:mobile_rhm/data/model/response/task/phong_ban.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import 'create_sub_task_state.dart';

class CreateSubTaskLogic extends GetxController {
  final CreateSubTaskState state = CreateSubTaskState();

  final RHMService _rhmService = Get.find<RHMService>();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskInfoController = TextEditingController();

  final GroupButtonController groupTaskStatusController = GroupButtonController();

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
      taskInfoController.text = state.task?.motacongviec ?? '';
    }

    taskNameController.addListener(() {
      state.errorTaskName.value = '';
    });

    state.statusOfWorks.value = TaskStatus.TASK_CREATE_FILTER;

    if (state.task != null) {
      state.selectedStatusOfWork = TaskStatus.TASK_CREATE_FILTER.firstWhere((element) => element.key == '${state.task!.status}');
      groupTaskStatusController.selectIndex(TaskStatus.TASK_CREATE_FILTER.indexWhere((element) => element.key == state.selectedStatusOfWork?.key));
    } else {
      state.selectedStatusOfWork = TaskStatus.TASK_CREATE_FILTER.first;
      groupTaskStatusController.selectIndex(0);
    }

    //TODO: init start time and endtime
    if (state.task != null) {
      String? startTime = state.task?.ngaygiao;
      if (startTime.isNotNullOrEmpty) {
        LogUtils.logE(message: 'Start date $startTime');
        DateTime? date = _convertTime(timeInString: startTime, formatDate: 'yyyy-MM-dd');
        if (date != null) {
          DateFormat originalFormat = DateFormat('dd/MM/yyyy');
          state.selectedStartDateTime.value = date;
          state.dateTimeStartValue.value = originalFormat.format(date);
        }
      }

      String? endTime = state.task?.ngayhoanthanh;
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

    _loadStaff();

    //TODO: Check CRUD
    if (state.task == null) {
      state.isAllowCRUD.value = true;
    } else {
      UserProfile? user = _rhmService.userService.getUserProfile();
      if (_rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.CONGVIEC_UPDATE)) {
        state.isAllowCRUD.value = true;
        if (state.task?.status == TaskStatus.COMPLETED || state.task?.status == TaskStatus.CANCELED) {
          state.isAllowCRUD.value = false;
        }
      }
    }
  }

  void updateEmployee(RxMap<String, List<Employee>> staffs, Nguoiphoihop updatedEmployee) {
    LogUtils.logE(message: 'updateEmployee ${updatedEmployee.ten}');
    bool employeeUpdated = false;

    // Duyệt qua tất cả các key trong RxMap
    staffs.forEach((key, employees) {
      // Tìm index của nhân viên cần cập nhật dựa trên id
      int index = employees.indexWhere((employee) => employee.id == updatedEmployee.id);

      if (index != -1) {
        // Thay thế nhân viên cũ bằng nhân viên đã cập nhật
        employees[index].isSelect = true;

        // Cập nhật lại danh sách trong map
        staffs[key] = List<Employee>.from(employees);
        employeeUpdated = true;
      }
    });

    if (!employeeUpdated) {
      print('Employee with id ${updatedEmployee.id} not found');
    }
  }

  void _loadStaff() async {
    _rhmService.metadataService.getPhongBan().then((value) {
      state.phongBans.value = value;
      LogUtils.logE(message: 'Get phong ban OK size = ${state.phongBans.length} ${state.phongBans.first.ten}');
      _rhmService.metadataService.getEmployeeAndDep(phongban_ids: state.phongBans.map((element) => "${element.id}").toList()).then((staff) {
        if (staff != null) {
          state.staffs.value = staff;
          //TODO: Check staff
          if (state.task != null) {
            for (Nguoiphoihop user in (state.task!.nguoiphoihop ?? [])) {
              updateEmployee(state.staffs, user);
            }
          }
          state.staffs.refresh();
        }
      });
    });
  }

  void selectTaskStartTime() async {
    Widget datetimePick = DateTimePicker(
      onSelect: (DateTime date) {
        LogUtils.logE(message: 'Select date time');
        state.selectedStartDateTime.value = date;
        state.dateTimeStartValue.value = '${date.day}/${date.month}/${date.year}';
        state.errorStartTime.value = '';
      },
      initDate: state.selectedStartDateTime.value,
      title: AppStrings.subtask_assign_date.tr,
    );
    await Get.bottomSheet(datetimePick);
  }

  void selectTaskEndTime() async {
    Widget datetimePick = DateTimePicker(
      onSelect: (DateTime date) {
        LogUtils.logE(message: 'Select date time');
        state.selectedEndDateTime.value = date;
        state.dateTimeEndValue.value = '${date.day}/${date.month}/${date.year}';
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

  void addFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: FileExtension.EXTENSTION,
    );
    if (result != null) {
      state.attachFiles.addAll(result.files);
      state.attachFiles.toSet().toList();
      state.attachFiles.refresh();
    } else {
      // User canceled the picker
    }
  }

  void selectStatusOfWork(OptionModel selected) {
    state.selectedStatusOfWork = selected;
  }

  void onStaffChange({required Employee staff, required PhongBan dep}) {
    List<Employee> employees = state.staffs[dep.id.toString()] ?? [];
    for (Employee employee in employees) {
      if (employee.id == staff.id) {
        employee.isSelect = staff.isSelect;
        break;
      }
    }
    state.staffs.refresh();
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

  List<num> _createStaffRequest() {
    List<num> staffIds = [];
    state.staffs.forEach((key, employeeList) {
      for (Employee employee in employeeList) {
        if (employee.isSelect == true) {
          // String key = 'nhanvieninput[${employee.id}]';
          // String value = employee.taskRole.value == 0 ? TaskRole.PRIMARY : TaskRole.SECOND_PRIMARY;
          // staffMap[key] = value;
          staffIds.add(employee.id!);
        }
      }
    });
    return staffIds;
  }

  void _submitTask() async {
    try {
      DialogUtils.showLoading();
      List<num> staffIds = _createStaffRequest();
      DateFormat originalFormat = DateFormat('dd/MM/yyyy');
      DateFormat newFormat = DateFormat('yyyy-MM-dd');

      List<Dio.MultipartFile> files = await _createFiles();
      var request;
      if (state.task == null) {
        request = {
          'congviec_id': state.taskId,
          'Congviec[tencongviec]': taskNameController.text,
          'Congviec[motacongviec]': taskInfoController.text,
          'Congviec[ngaygiao]':
              state.dateTimeStartValue.value.isNotNullOrBlank ? newFormat.format(originalFormat.parse(state.dateTimeStartValue.value)) : '',
          'Congviec[ngayhoanthanh]':
              state.dateTimeEndValue.value.isNotNullOrBlank ? newFormat.format(originalFormat.parse(state.dateTimeEndValue.value)) : '',
          'Congviec[status]': state.selectedStatusOfWork?.key,
          'fileinp[]': files,
          'listnguoinhanphoihop[]': staffIds,
        };
      } else {
        request = {
          'id': state.task?.id,
          'Congviec[tencongviec]': taskNameController.text,
          'Congviec[motacongviec]': taskInfoController.text,
          'Congviec[ngaygiao]':
              state.dateTimeStartValue.value.isNotNullOrBlank ? newFormat.format(originalFormat.parse(state.dateTimeStartValue.value)) : '',
          'Congviec[ngayhoanthanh]':
              state.dateTimeEndValue.value.isNotNullOrBlank ? newFormat.format(originalFormat.parse(state.dateTimeEndValue.value)) : '',
          'Congviec[status]': state.selectedStatusOfWork?.key,
          'fileinp[]': files,
          'listnguoinhanphoihop[]': staffIds,
        };
      }

      bool isCreateNew = state.task == null;

      LogUtils.log(request);
      Dio.FormData formData = Dio.FormData.fromMap(request);
      var res = await _rhmService.taskService.createOrUpdateSubTask(data: formData, isCreateNew: isCreateNew);
      DialogUtils.hideLoading();
      if (res != null && res['status'] == true) {
        _rhmService.toastService.showToast(
            message: state.task != null ? AppStrings.update_task_success.tr : AppStrings.create_new_task_success.tr,
            isSuccess: true,
            context: Get.context!);
        if (state.task != null) {
          NavigationUtils.popUtils(page: Routers.TASK_DETAIL);
        } else {
          NavigationUtils.popUtils(page: Routers.TASK_DETAIL);
        }
      } else {
        _rhmService.toastService.showToast(message: res['message'] ?? AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      }
    } catch (e) {
      DialogUtils.hideLoading();
      _rhmService.toastService.showToast(message: AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
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
        positiveText: state.task != null ? AppStrings.btn_update.tr : AppStrings.btn_new.tr,
        negativeText: AppStrings.btn_cancel.tr,
        onPositive: () {
          _submitTask();
        });
    DialogUtils.showCenterDialog(child: confirmSendView);
  }

  void createNewOrUpdateTask() {
    bool isValid = isFormValid();
    if (isValid) {
      confirmSubmitTask();
    } else {
      _rhmService.toastService.showToast(message: AppStrings.form_invalid_error.tr, isSuccess: false, context: Get.context!);
    }
  }

  _deleteFileAttach({required String file}) async {
    try {
      DialogUtils.showLoading();
      var request = {'file': file, 'id': state.task?.id};
      LogUtils.log(request);

      var res = await _rhmService.taskService.deleteFileOfSubTask(request: request);
      DialogUtils.hideLoading();
      if (res != null && res['status'] == true) {
        _rhmService.toastService.showToast(message: AppStrings.delete_file_success.tr, isSuccess: true, context: Get.context!);
        NavigationUtils.popUtils(page: Routers.TASK_DETAIL);
      } else {
        _rhmService.toastService.showToast(message: res['message'] ?? AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      }
    } catch (e) {
      DialogUtils.hideLoading();
      _rhmService.toastService.showToast(message: AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
    }
  }

  void onDeleteAttachment({required String file}) {
    Widget confirmSendView = WarningView(
        icon: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: ImageDisplay(
            Assets.ic_error,
            width: 36.w,
          ),
        ),
        title: AppStrings.confirm_delete_file.tr,
        positiveText: AppStrings.btn_delete.tr,
        negativeText: AppStrings.btn_cancel.tr,
        onPositive: () {
          _deleteFileAttach(file: file);
        });
    DialogUtils.showCenterDialog(child: confirmSendView);
  }
}
