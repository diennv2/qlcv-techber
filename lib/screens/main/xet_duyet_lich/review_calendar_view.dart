import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/app_widgets/home_search_view.dart';
import 'package:mobile_rhm/app_widgets/skeleton_loading.dart';
import 'package:mobile_rhm/app_widgets/task/task_calendar_item.dart';
import 'package:mobile_rhm/app_widgets/task/task_main_item.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/screens/main/xet_duyet_lich/review_calendar_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../app_widgets/dropdown/filter_dropdown.dart';
import '../../../core/languages/keys.dart';
import '../../../core/utils/log_utils.dart';
import 'review_calendar_logic.dart';

class ReviewCalendarPage extends StatefulWidget {
  final ScrollController scrollController;
  final GlobalKey<ScaffoldState> globalKey;
  final ReviewCalendarLogic homeLogic = Get.find<ReviewCalendarLogic>();
  final ReviewCalendarState state = Get.find<ReviewCalendarLogic>().state;

  ReviewCalendarPage({super.key, required this.scrollController, required this.globalKey}) {
    homeLogic.addScrollListener(scrollController: scrollController);
  }

  @override
  State<ReviewCalendarPage> createState() => _ReviewCalendarPageState();
}

class _ReviewCalendarPageState extends State<ReviewCalendarPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch duyệt lãnh đạo', style: AppTextStyle.bold_18),
      ),
      backgroundColor: AppColors.GrayLight,
      body: HideKeyBoard(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Obx(() {
                    return widget.state.taskResponse.value.dataProvider == null
                        ? RefreshIndicator(
                      onRefresh: () async {
                        await widget.homeLogic.reloadTask();  // Ensure reload task
                      },
                      child: ListView(
                        children: const [
                          SkeletonLoadingView(count: 10),
                        ],
                      ),
                    )
                        : widget.state.taskResponse.value.dataProvider!.isEmpty
                        ? const Center(
                      child: EmptyView(),
                    )
                        : RefreshIndicator(
                      onRefresh: () async {
                        await widget.homeLogic.reloadTask();  // Refresh task data
                      },
                      child: ListView(
                        controller: widget.scrollController,
                        children: [
                          ...widget.state.taskResponse.value.dataProvider!.map((task) {
                            LogUtils.logE(message: 'Task item: $task');
                            return TaskCalendarItemView(
                              name: task.ten ?? '',
                              lanhdao: task.lanhdaophutrach ?? '',
                              deadlineTime: task.ngayketthuc ?? '',
                              onDetail: () {
                                widget.homeLogic.onDetailTask(task: task);
                              },
                              startTime: task.ngaybatdau ?? '',
                              isShowFull: false,
                              nguoitao: task.nguoitao ?? '',
                              nguoiduyet: task.nguoiduyet ?? '',
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
