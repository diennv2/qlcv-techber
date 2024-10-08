import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/constants/tabs.dart';
import 'package:mobile_rhm/data/model/common/bottom_tab_model.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import '../../core/values/assets.dart';
import 'main_page_state.dart';

class MainPageLogic extends GetxController {
  final MainPageState state = MainPageState();
  final RHMService _rhmService = Get.find<RHMService>();
  final PageController pageViewController = PageController(initialPage: TabConst.TAB_HOME, keepPage: true);
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    addScrollListener();
  }

  void addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!state.isScrollingDown.value) {
          state.isScrollingDown.value = true;
          state.isFabExpanded.value = false;
        }
      } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (state.isScrollingDown.value) {
          state.isScrollingDown.value = false;
          state.isFabExpanded.value = true;
        }
      }
    });
  }

  void onPageChange({required int selectTabIndex}) {
    state.currentPage.value = selectTabIndex;
  }

  void createNewTask() {
    Get.toNamed(Routers.TASK_NEW);
  }
}
