import 'package:chatview/chatview.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/task/task_appbar_view.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/screens/task/detail/page/task_detail_info_page.dart';
import 'package:mobile_rhm/screens/task/detail/page/task_info_page.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../core/constants/task.dart';
import '../../../core/languages/keys.dart';
import '../../../core/values/colors.dart';
import 'page/task_comment_page.dart';
import 'task_detail_logic.dart';

class TaskDetailPage extends StatefulWidget {
  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> with TickerProviderStateMixin {
  final logic = Get.find<TaskDetailLogic>();
  final state = Get.find<TaskDetailLogic>().state;
  final ScrollController sc = ScrollController();
  late double pinnedHeaderHeight;
  late final TabController primaryTC;

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: 3, vsync: this);
    final double statusBarHeight = DeviceUtils.statusBarHeight();
    pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
  }

  @override
  void dispose() {
    primaryTC.dispose();
    sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (isCanPop) {
        Get.delete<TaskDetailLogic>();
      },
      child: ExtendedNestedScrollView(
        controller: sc,
        headerSliverBuilder: (BuildContext c, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                  Get.delete<TaskDetailLogic>();
                },
              ),
              pinned: true,
              backgroundColor: AppColors.White,
              elevation: 0,
              actions: state.isAllowCRUD.value
                  ? [
                      TouchableOpacity(
                        behavior: HitTestBehavior.translucent,
                        child: Container(padding: EdgeInsets.symmetric(horizontal: 16.w), child: const Icon(Icons.edit)),
                        onTap: () {
                          logic.updateTask();
                        },
                      )
                    ]
                  : null,
              expandedHeight: 240.0,
              scrolledUnderElevation: 0,
              title: innerBoxIsScrolled
                  ? Text(
                      state.task.ten ?? '',
                      style: AppTextStyle.body_text,
                    )
                  : const Text(''),
              flexibleSpace: FlexibleSpaceBar(
                //centerTitle: true,
                collapseMode: CollapseMode.pin,
                background: Container(
                  width: 1.0.sw,
                  margin: EdgeInsets.only(top: pinnedHeaderHeight, left: 16.w, right: 16.w),
                  color: Colors.white,
                  child: Obx(() {
                    return TaskAppBarView(
                      isImportant: state.task.isImportant ?? false,
                      name: state.task.ten ?? '',
                      status: state.task.status ?? 0,
                      statusLabel: state.statusText.value,
                      onChangeStatus: state.isAllowCRUD.value
                          ? () {
                              logic.onChangeStatusTask();
                            }
                          : null,
                    );
                  }),
                ),
              ),
            )
          ];
        },
        //1.[pinned sliver header issue](https://github.com/flutter/flutter/issues/22393)
        pinnedHeaderSliverHeightBuilder: () {
          return 80.h;
        },
        body: Scaffold(
          backgroundColor: AppColors.White,
          body: Column(
            children: [
              Container(
                color: AppColors.White,
                child: TabBar(
                  controller: primaryTC,
                  labelColor: AppColors.PrimaryText,
                  indicatorColor: AppColors.Primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.0,
                  isScrollable: false,
                  unselectedLabelColor: AppColors.SecondaryText,
                  tabs: <Tab>[
                    Tab(text: AppStrings.general_label.tr),
                    Tab(text: AppStrings.task_sub_list.tr),
                    Tab(text: AppStrings.task_comment.tr),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: primaryTC,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TaskInfoPage(logic: logic, state: state),
                  TaskDetailInfoPage(logic: logic, state: state),
                  Obx(() {
                    LogUtils.logE(message: 'Update Task comment page');
                    if (state.chatInfo.value.currentUser == null) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return TaskCommentPage(
                      chatInfo: state.chatInfo.value,
                      onAddComment: state.isAllowUpdateSubTask.value
                          ? (String message, ReplyMessage replyMessage) {
                              logic.addComment(message: message, replyMessage: replyMessage);
                            }
                          : null,
                      onUnSentMessage: state.isAllowUpdateSubTask.value
                          ? (Message message) {
                              logic.unsentMessage(message: message);
                            }
                          : null,
                      chatController: logic.chatController,
                    );
                  })
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
