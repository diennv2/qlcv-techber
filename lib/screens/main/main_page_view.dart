import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/drawer.dart';
import 'package:mobile_rhm/app_widgets/tab/main_bottom_view.dart';
import 'package:mobile_rhm/core/constants/tabs.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/screens/main/apps/application_view.dart';
import 'package:mobile_rhm/screens/main/home/home_view.dart';

import 'main_page_logic.dart';

class MainPagePage extends StatefulWidget {
  const MainPagePage({super.key});

  @override
  State<MainPagePage> createState() => _MainPagePageState();
}

class _MainPagePageState extends State<MainPagePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final logic = Get.find<MainPageLogic>();
  final state = Get.find<MainPageLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.White,
      floatingActionButton: Obx(() {
        if (state.currentPage.value != TabConst.TAB_HOME) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.only(bottom: state.isFabExpanded.value ? state.bottomBarHeight : 0),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: FloatingActionButton.extended(
                onPressed: () {
                  logic.createNewTask();
                },
                label: state.isFabExpanded.value
                    ? Text(
                        AppStrings.btn_new.tr,
                        style: AppTextStyle.regular_12,
                      )
                    : const Icon(
                        Icons.add,
                        size: 25,
                      )),
          ),
        );
      }),
      drawer: const SidebarDrawer(),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            top: false,
            child: Obx(() {
              return IndexedStack(
                index: state.currentPage.value,
                children: [
                  HomePage(
                    scrollController: logic.scrollController,
                    globalKey: _scaffoldKey,
                  ),
                  // Container(),
                  ApplicationPage()
                ],
              );
            }),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() {
              return MainBottomView(
                  height: state.isScrollingDown.value ? state.bottomBarHeight : 0,
                  onTabChange: (index) {
                    logic.onPageChange(selectTabIndex: index);
                  },
                  selectedPageIndex: state.currentPage.value);
            }),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    logic.scrollController.dispose();
  }
}
