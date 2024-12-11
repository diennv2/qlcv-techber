import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:intl/intl.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import '../../../app_widgets/date_time_picker2.dart';
import '../../../app_widgets/image_display.dart';
import '../../../app_widgets/warning_view.dart';
import '../../../core/languages/keys.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../core/values/assets.dart';
import '../../../data/model/response/calendar/calendar_task_response.dart';
import '../../../routers/app_pages.dart';
import 'calendar_detail_state.dart';

class CalendarDetailLogic extends GetxController {
  final CalendarDetailState state = CalendarDetailState();
  final RHMService _rhmService = Get.find<RHMService>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    LogUtils.logE(message: 'Goto Task onReady');
  }

  void fetchTaskDetailById(String id) async {
    try {
      var request = {'id': id};
      Dio.FormData formData = Dio.FormData.fromMap(request);

      final taskDetail = await _rhmService.calendarService.getTaskCalendarById(formData: formData);
      if (taskDetail != null && taskDetail.data != null) {
        state.task.value = taskDetail.data;
        updateControllersFromTask();
        LogUtils.logE(message: 'Fetched task: ${taskDetail.data?.tencongviec}');
      } else {
        LogUtils.logE(message: 'No task found with ID: $id');
      }
    } catch (e) {
      LogUtils.logE(message: 'Error fetching task: $e');
    }
  }

  void updateControllersFromTask() {
    final task = state.task.value;
    if (task != null) {
      state.startTimeController.text = task.starttime ?? '';
      state.endTimeController.text = task.endtime ?? '';
      state.taskNameController.text = task.tencongviec ?? '';
      state.ownerNameController.text = task.ownerName ?? '';
      state.lanhdaoNameController.text = task.lanhdaoName ?? ''; // Hiển thị lãnh đạo nếu có
      state.chitietController.text = task.chitiet ?? '';
      state.ghiChuController.text = task.ghichutunguoiduyet ?? '';
    }
  }


  Future<void> saveTaskDetail() async {
    try {
      final task = state.task.value;
      if (task == null) return;

      // Kiểm tra nếu `lanhdao` không null
      if (task.lanhdao != null) {
        final confirm = await Get.dialog<bool>(
          AlertDialog(
            title: Text('Cảnh báo'),
            content: Text('Cập nhật lịch hẹn với lãnh đạo sẽ đưa về trạng thái chờ duyệt! Tiếp tục?'),
            actions: [
              TextButton(
                child: Text('Hủy'),
                onPressed: () => Get.back(result: false),
              ),
              TextButton(
                child: Text('Tiếp tục'),
                onPressed: () => Get.back(result: true),
              ),
            ],
          ),
        );

        if (confirm != true) {
          return; // Nếu người dùng chọn "Hủy", dừng thực hiện
        }
      }

      // Tạo request không truyền `lanhdao`
      var request = {
        'id': task.id,
        'tencongviec': state.taskNameController.text,
        'chitiet': state.chitietController.text,
        'starttime': state.startTimeController.text,
        'endtime': state.endTimeController.text,
        'ghichutunguoiduyet': state.ghiChuController.text,
      };

      Dio.FormData formData = Dio.FormData.fromMap(request);
      LogUtils.logE(message: 'FormData: ${formData.fields.map((e) => e.toString()).join(', ')}');

      final response = await _rhmService.calendarService.createOrUpdateTask(data: formData, isCreateNew: false);

      if (response['status'] == true) {
        LogUtils.logE(message: 'Cập nhật công việc thành công');
        Get.snackbar('Thành công', 'Cập nhật công việc thành công');
        NavigationUtils.popUtils(page: Routers.CALENDAR_VIEW);
      } else {
        LogUtils.logE(message: 'Cập nhật công việc thất bại');
        Get.snackbar('Lỗi', 'Cập nhật công việc thất bại');
      }
    } catch (e) {
      LogUtils.logE(message: 'Lỗi khi cập nhật công việc: $e');
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi cập nhật công việc');
    } finally {
      // Bỏ trống nếu không có logic thêm
    }
  }


  Future<void> deleteTask() async {
    try {
      final task = state.task.value;
      if (task == null) return;

      Dio.FormData formData = Dio.FormData.fromMap({'id': task.id});
      final response = await _rhmService.calendarService.deleteTaskCalendar(formData: formData);

      if (response != null && response['status'] == true) {
        _rhmService.toastService.showToast(
            message: AppStrings.delete_task_success.tr,
            isSuccess: true,
            context: Get.context!);
        Get.back(result: true); // Trả về true để báo xóa thành công
      } else {
        _rhmService.toastService.showToast(message: response['message'] ?? AppStrings.error_common.tr, isSuccess: false, context: Get.context!);
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi xóa công việc');
    }
  }

  void selectTaskStartTime() async {
    Widget datetimePick = DateTimePicker2(
      onSelect: (DateTime date) {
        LogUtils.logE(message: 'Selected start date time');
        state.selectedStartDateTime.value = date;
        state.dateTimeStartValue.value = DateFormat('dd/MM/yyyy HH:mm').format(date);
        state.startTimeController.text = state.dateTimeStartValue.value;
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
        LogUtils.logE(message: 'Selected end date time');
        state.selectedEndDateTime.value = date;
        state.dateTimeEndValue.value = DateFormat('dd/MM/yyyy HH:mm').format(date);
        state.endTimeController.text = state.dateTimeEndValue.value;
      },
      initDate: state.dateTimeStartValue.value.isNotNullOrBlank
          ? state.selectedStartDateTime.value
          : state.selectedStartDateTime.value,
      title: AppStrings.task_end_time.tr,
    );
    await Get.bottomSheet(datetimePick);
  }

  bool isFormValid() {
    String taskName = state.taskNameController.text;
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
}