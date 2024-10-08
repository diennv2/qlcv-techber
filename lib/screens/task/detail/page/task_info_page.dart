import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/task/file_attach_section.dart';
import 'package:mobile_rhm/app_widgets/task/task_section_overview.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import '../task_detail_logic.dart';
import '../task_detail_state.dart';

class TaskInfoPage extends StatelessWidget {
  final TaskDetailLogic logic;
  final TaskDetailState state;

  const TaskInfoPage({super.key, required this.logic, required this.state});

  @override
  Widget build(BuildContext context) {
    String statusText = state.task.tiendocongviec?.displayText ?? '';
    if (state.task.status == TaskStatus.INPROGRESS) {
      if (state.task.tiendocongviec != null) {
        statusText =
            "$statusText ${state.task.tiendocongviec?.congviecdahoanthanh ?? 0}/${state.task.tiendocongviec?.tongcongviec ?? 0} (${state.task.tiendocongviec?.tylehoanthanh ?? 0}%)";
      }
    }

    return ListView(
      padding: EdgeInsets.only(top: 12.h, bottom: 36.h),
      children: [
        TaskOverViewSection(
          decoration: const BoxDecoration(color: AppColors.White),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          isImportant: state.task.isImportant ?? false,
          name: state.task.ten ?? '',
          departments: (state.task.phongbanphutrachList ?? []).map((pb) => pb.ten ?? '').toList(),
          phutrach: state.task.nguoiphutrachname ?? '',
          lanhdao: (state.task.lanhdaophutrachList ?? []).map((pb) => pb.ten ?? '').toList().join(", "),
          deadlineTime: state.task.deadline?.displayText ?? '',
          deadlineTimeTextColor: state.task.deadline?.textColor,
          status: state.task.status ?? 0,
          statusText: statusText,
          employee: (state.task.nguoinhanviec ?? []),
          startTime: state.task.ngaybatdau ?? '',
          khoKhanCount: (state.task.khokhanvuongmac ?? []).length,
          typeOfWork: state.task.loaiduanName ?? '',
          workProgress: state.task.tiendocongviec,
          khokhaDes: state.task.khokhanvuongmac,
          fileDinhKems: state.task.fileDinhKem,
          onOpenAttach: (file) {
            logic.openFile(file: file);
          },
        ),
        Container(
          height: 24.h,
          color: AppColors.GrayLight,
        ),
        TaskFileAttachmentSection(
          isAllowAddAttach: false,
          fileDinhKems: state.task.fileDinhKem,
          onOpenAttach: (file) {
            LogUtils.logE(message: 'Open File $file');
            logic.openFile(file: file);
          },
          onAddAttach: () {
            logic.addAttachFile();
          },
        )
      ],
    );
  }
}
