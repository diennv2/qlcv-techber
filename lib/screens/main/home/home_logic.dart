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
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
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
  }

  void _initData() {
    loadTaskFilter().then((taskFilters) {
      if (taskFilters != null) {
        state.taskFilters.value = taskFilters;
        state.taskFilters.refresh();
      }
      loadTask();
    });
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

  Future<List<TaskFilter>?> loadTaskFilter() async {
    return await _rhmService.metadataService.getTaskFilters();
  }

  RequestFilter _getRequestFilter() {
    RequestFilter requestFilter = RequestFilter();
    for (TaskFilter filter in state.taskFilters) {
      if (filter.type == FilterType.STATUS) {
        requestFilter.statusFilter = filter.selected.value.key;
      } else if (filter.type == FilterType.NGUOI_PHU_TRACH) {
        requestFilter.nguoinhanviecFilter = filter.selected.value.key;
      } else if (filter.type == FilterType.PHONG_BAN) {
        requestFilter.phongbanid = filter.selected.value.key;
      } else if (filter.type == FilterType.LOAI_DU_AN) {
        requestFilter.loaiduanFilter = filter.selected.value.key;
      }
    }
    requestFilter.tenFilter = searchTaskNamController.text;
    return requestFilter;
  }

  Future<void> loadTask() async {
    if (state.currentPage.value == 1) {
      state.isLoadMore.value = false;
    } else {
      state.isLoadMore.value = true;
    }
    RequestFilter requestFilter = _getRequestFilter();

    _rhmService.taskService
        .getTasksByFilter(
            page: state.currentPage.value,
            statusFilter: requestFilter.statusFilter,
            phongbanid: requestFilter.phongbanid,
            nguoinhanviecFilter: requestFilter.nguoinhanviecFilter,
            loaiduanFilter: requestFilter.loaiduanFilter,
            tenFilter: requestFilter.tenFilter)
        .then((value) {
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
    }, onError: (_) {
      state.isLoadMore.value = false;
    });
  }

  Future<void> reloadTask() async {
    state.currentPage.value = 1;
    state.isLoadMore.value = false;
    state.totalPage.value = 0;
    state.taskResponse.value = TasksResponse();
    await loadTask();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onDetailTask({required TaskDetail task}) {
    Get.toNamed(Routers.TASK_DETAIL, arguments: {AppExtraData.DATA: task}, preventDuplicates: true);
    // Get.toNamed(Routers.CHAT_SCREEN);
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

  RxBool get isShowAllTask {
    bool isShowAll = true;
    for (var filter in state.taskFilters) {
      isShowAll = isShowAll && filter.selected.value.key.isNullOrEmpty;
    }
    return isShowAll.obs;
  }

  void deleteFilter() {
    if (isShowAllTask.value) {
      return;
    }
    for (TaskFilter taskFilter in state.taskFilters) {
      taskFilter.selected.value = OptionModel();
    }
    reloadTask();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    taskNameFilter.close();
    searchTaskNamController.dispose();
    super.dispose();
  }
}
