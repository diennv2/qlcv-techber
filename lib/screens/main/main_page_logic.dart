import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/permisson/permisson_list.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/constants/tabs.dart';
import 'package:mobile_rhm/data/model/common/bottom_tab_model.dart';
import 'package:mobile_rhm/data/model/response/user/me/UserProfile.dart';
import 'package:mobile_rhm/routers/app_pages.dart';

import '../../core/values/assets.dart';
import 'main_page_state.dart';

class MainPageLogic extends GetxController {
  final MainPageState state = MainPageState();
  final RHMService _rhmService = Get.find<RHMService>();
  final PageController pageViewController = PageController(initialPage: TabConst.TAB_HOME, keepPage: true);
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();


  @override
  void onInit() {
    super.onInit();
    addScrollListener();
    // checkPlanPagePermission();
  }

  void addScrollListener() {
    scrollController1.addListener(() {
      if (scrollController1.position.userScrollDirection == ScrollDirection.reverse) {
        if (!state.isScrollingDown.value) {
          state.isScrollingDown.value = true;
          state.isFabExpanded.value = false;
        }
      } else if (scrollController1.position.userScrollDirection == ScrollDirection.forward) {
        if (state.isScrollingDown.value) {
          state.isScrollingDown.value = false;
          state.isFabExpanded.value = true;
        }
      }
    });
  }
  void addScrollListener2() {
    scrollController2.addListener(() {
      if (scrollController2.position.userScrollDirection == ScrollDirection.reverse) {
        if (!state.isScrollingDown.value) {
          state.isScrollingDown.value = true;
          state.isFabExpanded.value = false;
        }
      } else if (scrollController2.position.userScrollDirection == ScrollDirection.forward) {
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

  void createNewPlan() {
    Get.toNamed(Routers.PLAN_NEW);
  }
  // void checkPlanPagePermission() {
  //   UserProfile? user = _rhmService.userService.getUserProfile();
  //   if (_rhmService.metadataService.hasPermission(permission: user?.permission ?? [], checkPermisson: PermissonList.KEHOACH_INDEX)) {
  //     state.hasPlanPageAccess.value = true;
  //   }
  // }
}
