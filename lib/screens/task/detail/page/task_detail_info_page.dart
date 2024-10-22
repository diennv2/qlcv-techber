import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/skeleton_loading.dart';
import 'package:mobile_rhm/app_widgets/task/subtask_section.dart';
import 'package:mobile_rhm/core/constants/keys.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';
import 'package:mobile_rhm/data/model/response/task/sub_task_progress_response.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';
import 'package:mobile_rhm/routers/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import '../task_detail_logic.dart';
import '../task_detail_state.dart';

class TaskDetailInfoPage extends StatelessWidget {
  final TaskDetailLogic logic;
  final TaskDetailState state;

  const TaskDetailInfoPage({super.key, required this.logic, required this.state});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return state.subTasks.value.dataProvider == null
          ? const SkeletonLoadingView(
              count: 3,
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: ListView(
                controller: logic.taskDetailController,
                padding: EdgeInsets.zero,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Obx(() {
                        return SubTaskSectionView(
                          onShowDetailReport: (Baocaocongviec report, SubTaskDetail detail) {
                            logic.onShowDetailReport(report: report, task: detail);
                          },
                          isAllowUpdate: state.isAllowUpdateSubTask.value,
                          subTasks: state.subTasks.value.dataProvider,
                          subTasksProgress: state.subTasksProgress.value,
                          onAddSubTask: () {
                            Get.toNamed(Routers.SUB_TASK_NEW, arguments: {AppExtraData.ID: state.task.id});
                          },
                          onOpenAttach: (file) {
                            logic.openFile(file: file);
                          },
                          onUpdateSubTask: (SubTaskProgressResponse? detail) {
                            logic.updateSubTask(subTask: detail);
                          },
                          isAllowAdd: state.isAllowAddSubTask.value,
                          isAllowAddReport: state.isAllowAddReport,
                          onAddReport: (SubTaskDetail detail) {
                            LogUtils.logE(message: 'Call add new report');
                            logic.addNewReport(task: detail);
                          },
                        );
                      })),
                  Obx(() {
                    LogUtils.logE(message: 'state.isLoadMore.value = ${state.isLoadMore.value}');
                    return state.isLoadMore.value
                        ? const Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.Primary,
                        ))
                        : const SizedBox.shrink();
                  }),
                ],
              ),
            );
    });
  }
}
