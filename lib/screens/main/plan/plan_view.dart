import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/app_widgets/home_search_view.dart';
import 'package:mobile_rhm/app_widgets/skeleton_loading.dart';
import 'package:mobile_rhm/app_widgets/task/task_main_item.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/screens/main/plan/plan_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../app_widgets/dropdown/filter_dropdown.dart';
import '../../../core/languages/keys.dart';
import 'plan_logic.dart';

class PlanPage extends StatefulWidget {
  final ScrollController scrollController;
  final GlobalKey<ScaffoldState> globalKey;
  final PlanLogic planLogic = Get.find<PlanLogic>();
  final PlanState state = Get.find<PlanLogic>().state;

  PlanPage({super.key, required this.scrollController, required this.globalKey}) {
    planLogic.addScrollListener(scrollController: scrollController);
  }

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.GrayLight,
      body: HideKeyBoard(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return HomeSearchView(
                      onOpenDrawer: () {
                        widget.globalKey.currentState!.openDrawer();
                      },
                      hasTextSearch: widget.state.searchTaskName.value.isNotNullOrEmpty,
                      textEditingController: widget.planLogic.searchTaskNamController,
                    );
                  }),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 1.0.sw,
                    child: Obx(() {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Obx(() {
                            return TouchableOpacity(
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.Border),
                                    color: widget.planLogic.isShowAllTask.value ? AppColors.Primary.withOpacity(0.5) : AppColors.White),
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.btn_delete_filter.tr,
                                  style: AppTextStyle.regular_12,
                                ),
                              ),
                              onTap: () {
                                widget.planLogic.deleteFilter();
                              },
                            );
                          }),
                          ...widget.state.taskFilters.map((filter) {
                            return FilterDropDownView(
                                countSelected: filter.selected.value.key.isNotNullOrEmpty,
                                onPress: () {
                                  widget.planLogic.showFilter(filter: filter);
                                },
                                label: filter.label ?? '');
                          })
                        ],
                      );
                    }),
                  ),
                  Expanded(child: Obx(() {
                    return widget.state.taskResponse.value.dataProvider == null
                        ? RefreshIndicator(
                            onRefresh: () async {
                              await widget.planLogic.reloadTask();
                            },
                            child: ListView(
                              children: const [
                                SkeletonLoadingView(
                                  count: 10,
                                ),
                              ],
                            ),
                          )
                        : widget.state.taskResponse.value.dataProvider!.isEmpty
                            ? const Center(
                                child: EmptyView(),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  await widget.planLogic.reloadTask();
                                },
                                child: ListView(
                                  controller: widget.scrollController,
                                  children: [
                                    ...widget.state.taskResponse.value.dataProvider!.map((task) {
                                      String statusText = task.tiendocongviec?.displayText ?? '';
                                      if (task.status == TaskStatus.INPROGRESS) {
                                        if (task.tiendocongviec != null) {
                                          statusText =
                                              "$statusText ${task.tiendocongviec?.congviecdahoanthanh ?? 0}/${task.tiendocongviec?.tongcongviec ?? 0} (${task.tiendocongviec?.tylehoanthanh ?? 0}%)";
                                        }
                                      }
                                      return TaskMainItemView(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
                                        isImportant: task.isImportant ?? false,
                                        name: task.ten ?? '',
                                        departments: (task.phongbanphutrachList ?? []).map((pb) => pb.ten ?? '').toList(),
                                        phutrach: task.nguoiphutrachname ?? '',
                                        lanhdao: (task.lanhdaophutrachList ?? []).map((pb) => pb.ten ?? '').toList().join(", "),
                                        deadlineTime: task.deadline?.displayText ?? '',
                                        deadlineTimeTextColor: task.deadline?.textColor,
                                        status: task.status ?? 0,
                                        statusText: statusText,
                                        onDetail: () {
                                          widget.planLogic.onDetailTask(task: task);
                                        },
                                        employee: (task.nguoinhanviec ?? []),
                                        startTime: task.ngaybatdau ?? '',
                                        khoKhanCount: (task.khokhanvuongmac ?? []).length,
                                        typeOfWork: task.loaiduanName ?? '',
                                        workProgress: task.tiendocongviec,
                                        khokhaDes: task.khokhanvuongmac,
                                        isShowFull: false,
                                      );
                                    }),
                                    Obx(() {
                                      return widget.state.isLoadMore.value
                                          ? const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: CupertinoActivityIndicator(
                                                  color: AppColors.Primary,
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink();
                                    })
                                  ],
                                ),
                              );
                  })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
