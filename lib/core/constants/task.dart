import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/data/model/common/opttion_model.dart';
import 'package:mobile_rhm/data/model/response/task/tien_do_cong_viec.dart';

import '../languages/keys.dart';
import '../values/assets.dart';
import '../values/colors.dart';

abstract class TaskStatus {
  static const INPROGRESS = 0; //Đang thực hiện
  static const COMPLETED = 1; //Đã hoàn thành
  static const PAUSING = 2; //Đang tạm dừng
  static const CANCELED = 3; //Đã huỷ
  static const UNDEVELOPED = 4; //Chưa triển khai
  static const DUE_DATE_COMMING = 5; //Sắp đến hạn
  static const LATE_DEADLINE = 6; //Qúa hạn
  static OptionModel DEFAULT_FILTER = OptionModel(value: AppStrings.task_all.tr, key: '');
  static List<OptionModel> TASK_FILTER = [
    DEFAULT_FILTER,
    OptionModel(value: AppStrings.task_inprogress.tr, key: '$INPROGRESS'),
    OptionModel(value: AppStrings.task_completed.tr, key: '$COMPLETED'),
    OptionModel(value: AppStrings.task_pausing.tr, key: '$PAUSING'),
    OptionModel(value: AppStrings.task_canceled.tr, key: '$CANCELED'),
    OptionModel(value: AppStrings.task_undeveloped.tr, key: '$UNDEVELOPED'),
    OptionModel(value: AppStrings.task_duedate_comming.tr, key: '$DUE_DATE_COMMING'),
    OptionModel(value: AppStrings.task_late_deadling.tr, key: '$LATE_DEADLINE'),
  ];

  static List<OptionModel> TASK_CREATE_FILTER = [
    OptionModel(value: AppStrings.task_inprogress.tr, key: '$INPROGRESS'),
    OptionModel(value: AppStrings.task_completed.tr, key: '$COMPLETED'),
    OptionModel(value: AppStrings.task_pausing.tr, key: '$PAUSING'),
    OptionModel(value: AppStrings.task_canceled.tr, key: '$CANCELED'),
    OptionModel(value: AppStrings.task_undeveloped.tr, key: '$UNDEVELOPED'),
  ];

  static Color textColorByStatus({required num status}) {
    switch (status) {
      case TaskStatus.COMPLETED:
        return AppColors.SuccessText;
      case TaskStatus.CANCELED:
        return AppColors.Red;
      case TaskStatus.LATE_DEADLINE:
        return AppColors.Red;
      case TaskStatus.DUE_DATE_COMMING:
        return Colors.amber;
    }
    return AppColors.PrimaryText;
  }

  static String statusText({required num status, Tiendocongviec? progress}) {
    if (status == TaskStatus.INPROGRESS && progress != null) {
      String statusText =
          "${progress.displayText} ${progress.congviecdahoanthanh ?? 0}/${progress.tongcongviec ?? 0} (${progress.tylehoanthanh ?? 0}%)";
      return statusText;
    }

    switch (status) {
      case TaskStatus.INPROGRESS:
        return AppStrings.task_inprogress.tr;
      case TaskStatus.COMPLETED:
        return AppStrings.task_completed.tr;
      case TaskStatus.PAUSING:
        return AppStrings.task_pausing.tr;
      case TaskStatus.CANCELED:
        return AppStrings.task_canceled.tr;
      case TaskStatus.UNDEVELOPED:
        return AppStrings.task_undeveloped.tr;
      case TaskStatus.DUE_DATE_COMMING:
        return AppStrings.task_duedate_comming.tr;
      case TaskStatus.LATE_DEADLINE:
        return AppStrings.task_late_deadling.tr;
    }
    return '';
  }

  static Widget iconView({required num status}) {
    switch (status) {
      case TaskStatus.COMPLETED:
        return ImageDisplay(
          Assets.ic_checked_circle,
          width: 16.w,
          color: AppColors.SuccessText,
        );
      case TaskStatus.INPROGRESS:
        return ImageDisplay(
          Assets.ic_circle,
          width: 16.w,
          color: AppColors.PrimaryText,
        );
      case TaskStatus.CANCELED:
        return ImageDisplay(
          Assets.ic_circle,
          width: 16.w,
          color: AppColors.Red,
        );
      case TaskStatus.LATE_DEADLINE:
        return ImageDisplay(
          Assets.ic_deadline,
          width: 16.w,
          color: AppColors.Red,
        );
      case TaskStatus.DUE_DATE_COMMING:
        return ImageDisplay(
          Assets.ic_due_date,
          width: 16.w,
          color: Colors.amber,
        );
    }
    return ImageDisplay(
      Assets.ic_circle,
      width: 16.w,
      color: AppColors.PrimaryText,
    );
  }
}

abstract class TaskRole {
  static const String PRIMARY = 'xulychinh';
  static const String SECOND_PRIMARY = 'phoihop';
}

abstract class TaskCommentConst {
  static const String REVERT_COMMENT = '@thuhoithuhoi@';
}
