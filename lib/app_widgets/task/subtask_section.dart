import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/app_widgets/task/subtask_item.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/task/sub_task_progress_response.dart';
import 'package:mobile_rhm/data/model/response/task/subtask_list_response.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class SubTaskSectionView extends StatelessWidget {
  final Function? onOpenAttach;
  final Function? onAddSubTask;
  final Function? onAddReport;
  final EdgeInsetsGeometry? padding;
  final List<SubTaskDetail>? subTasks;
  final Map<num, SubTaskProgressResponse>? subTasksProgress;
  final bool isAllowUpdate;
  final bool isAllowAddReport;
  final bool isAllowAdd;
  final Function? onUpdateSubTask;
  final Function? onShowDetailReport;

  const SubTaskSectionView(
      {super.key,
      required this.isAllowUpdate,
      required this.isAllowAdd,
      required this.isAllowAddReport,
      this.onOpenAttach,
      this.onAddSubTask,
      this.onAddReport,
      this.padding,
      this.subTasks,
      this.onShowDetailReport,
      this.subTasksProgress,
      this.onUpdateSubTask});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    isAllowAdd ? AppStrings.add_subtask_label.tr : AppStrings.subtask_list_label.tr,
                    style: AppTextStyle.medium_16,
                  ),
                ),
                if (isAllowAdd)
                  TouchableOpacity(
                    child: const Icon(
                      Icons.add_circle_outline,
                    ),
                    onTap: () {
                      onAddSubTask?.call();
                    },
                  )
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          if (subTasks == null || subTasks?.isEmpty == true)
            Container(
              margin: EdgeInsets.only(top: 72.h),
              child: const EmptyView(),
            ),
          if (subTasks != null && subTasksProgress != null)
            ...(subTasks ?? []).map((subTask) {
              LogUtils.logE(message: 'subTask.id = ${subTask.id} - subTasksProgress = ${subTasksProgress![subTask.id ?? 0]?.tencongviec}');
              return SubTaskItemView(
                onShowDetailReport: (report) {
                  onShowDetailReport?.call(report, subTask);
                },
                detail: subTasksProgress![subTask.id ?? 0],
                baocaocongviec: subTasksProgress![subTask.id ?? 0]?.baocaocongviec ?? [],
                onAttachOpen: (file) {
                  onOpenAttach?.call(file);
                },
                isAllowUpdate: isAllowUpdate,
                onUpdateSubTask: onUpdateSubTask,
                isAllowAddReport: isAllowAddReport,
                onAddReport: () {
                  LogUtils.logE(message: 'Call add new report');
                  onAddReport?.call(subTask);
                },
              );
            }),
        ],
      ),
    );
  }
}
