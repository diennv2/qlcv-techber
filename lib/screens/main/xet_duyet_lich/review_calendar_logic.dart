import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/bus_service.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/common/request_filter.dart';
import 'package:mobile_rhm/data/model/common/task_filter.dart';
import 'package:mobile_rhm/data/model/response/task/task.dart';
import 'package:mobile_rhm/routers/app_pages.dart';
import 'package:rxdart/rxdart.dart';

import '../../../app_widgets/meta/list/common_option_list.dart';
import '../../../data/model/response/calendar/task_calendar.dart';
import 'review_calendar_state.dart';

class ReviewCalendarLogic extends GetxController {
  final ReviewCalendarState state = ReviewCalendarState();
  final RHMService _rhmService = Get.find<RHMService>();
  final TextEditingController searchTaskNamController = TextEditingController();
  final taskNameFilter = BehaviorSubject<String>();
  bool isFirstTimeFocus = false;
  String _lastQuery = '';

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    _initData();
    await reloadTask();
  }

  void _initData() {
    taskNameFilter
        .debounceTime(const Duration(milliseconds: 1000)) // Debounce duration
        .listen((text) {
      LogUtils.logE(message: 'Text change to $text');

      if (isFirstTimeFocus == false) {
        isFirstTimeFocus = true;
        return;
      }
      if (text != _lastQuery) {
        LogUtils.logE(message: 'Cal API');
        _lastQuery = text;
        reloadTask();
      }
    });

    searchTaskNamController.addListener(() {
      LogUtils.logE(message: 'Text change');
      state.searchTaskName.value = searchTaskNamController.text;
      taskNameFilter.add(searchTaskNamController.text);
    });

    _rhmService.eventBusService.listenEvent<EventNewTaskAdd>(onListen: (event) {
      reloadTask();
    });
  }
  Future<void> loadTask() async {
    if (state.currentPage.value == 1) {
      state.isLoadMore.value = false;
    } else {
      state.isLoadMore.value = true;
    }

    _rhmService.calendarService
        .getTasksCalendar(page: state.currentPage.value)
        .then((value) {
      LogUtils.logE(message: 'API response: $value');
      state.isLoadMore.value = false;
      if (value != null) {
        state.totalPage.value = (value.pages ?? 0).toInt();
        if (state.currentPage.value == 1) {
          state.taskResponse.value = value;
        } else {
          (state.taskResponse.value.dataProvider ?? []).addAll(value.dataProvider ?? []);
          state.taskResponse.refresh();
        }
      }
      // Log dữ liệu của taskResponse sau khi gán
      LogUtils.logE(message: 'TaskResponse: ${state.taskResponse.value}');
    }, onError: (error) {
      LogUtils.logE(message: 'API error: $error');
      state.isLoadMore.value = false;
    });
  }

  Future<void> reloadTask() async {
    state.currentPage.value = 1;
    state.isLoadMore.value = false;
    state.totalPage.value = 0;
    state.taskResponse.value = AllLichHenResponse();  // Reset data
    await loadTask();  // Load again
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onDetailTask({required LichHenDetail task}) {
    Get.defaultDialog(
      title: "Xác nhận duyệt lịch",
      titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      middleText: "Bạn có muốn duyệt lịch này?",
      middleTextStyle: TextStyle(fontSize: 16),
      textCancel: "Hủy",
      cancelTextColor: Colors.red,
      textConfirm: "Đồng ý",
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,
      backgroundColor: Colors.white,
      radius: 10,
      onCancel: () {
        // Hành động khi bấm "Hủy"
        Get.back();
      },
      onConfirm: () {
        _rhmService.calendarService
            .updateStatus(id: task.id!)
            .then((value) {
          // Thông báo khi cập nhật thành công
          Get.snackbar('Thành công', 'Cập nhật lịch thành công');

          // Quay lại trang trước
          Get.back();

          // Load lại dữ liệu trang trước (ví dụ trang lịch)
          Get.find<ReviewCalendarLogic>().reloadTask();  // Giả sử bạn có phương thức này trong logic của trang

        }, onError: (error) {
          // Thông báo lỗi khi cập nhật thất bại
          Get.snackbar('Lỗi', 'Cập nhật lịch không thành công');
          LogUtils.logE(message: 'API error: $error');
        });
      },
    );
  }



  void addScrollListener({required ScrollController scrollController}) {
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 300 && !state.isLoadMore.value) {
        if (state.currentPage.value < state.totalPage.value) {
          state.currentPage.value = state.currentPage.value + 1;
          loadTask();
        }
      }
    });
  }

  Future<void> showFilter({required TaskFilter filter}) async {
    Widget bottomSheet = CommonOptionListView(
      optionItems: filter.options ?? [],
      onSelect: (OptionModel item) {
        LogUtils.logE(message: 'Selected item');
        LogUtils.log(item);
        if (item.key != filter.selected.value.key) {
          filter.onSelectOption(item: item);
          reloadTask();
        }
      },
      selected: filter.selected.value,
      title: filter.label ?? '',
    );

    await Get.bottomSheet(bottomSheet, isScrollControlled: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    taskNameFilter.close();
    searchTaskNamController.dispose();
    super.dispose();
  }
}
