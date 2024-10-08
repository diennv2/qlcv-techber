import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';

import '../../core/values/colors.dart';

class BadgeView extends StatelessWidget {
  final num status;
  final String? text;
  final bool? isImportant;
  final bool? isHard;

  const BadgeView({super.key, required this.status, this.text, this.isImportant, this.isHard});

  @override
  Widget build(BuildContext context) {
    if (isImportant == true) {
      return ImageDisplay(
        Assets.ic_flag,
        color: Colors.red,
        height: 16.h,
      );
    }
    return Container(
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Text(
        text ?? textStatus,
        textAlign: TextAlign.center,
        style: AppTextStyle.medium_10.copyWith(color: textColor),
      ),
    );
  }

  Color get bgColor {
    if (isImportant == true) {
      return Colors.deepOrange;
    }
    if (isHard == true) {
      return Colors.orange;
    }

    switch (status) {
      case TaskStatus.INPROGRESS:
        return const Color(0xFF2E90FA);
      case TaskStatus.COMPLETED:
        return const Color(0xFF38A169);
      case TaskStatus.PAUSING:
        return const Color(0xFFFFF6ED);
      case TaskStatus.CANCELED:
        return const Color(0xFFF0FFF4);
      case TaskStatus.UNDEVELOPED:
        return const Color(0xFFF0FFF4);
      case TaskStatus.DUE_DATE_COMMING:
        return const Color(0xFFF0FFF4);
      case TaskStatus.LATE_DEADLINE:
        return const Color(0xFFF0FFF4);
    }
    return const Color(0xFFEFF8FF);
  }

  Color get textColor {
    if (isImportant == true || isHard == true) {
      return Colors.white;
    }

    switch (status) {
      case TaskStatus.INPROGRESS:
        return AppColors.White;
      case TaskStatus.PAUSING:
        return AppColors.SecondaryText;
      case TaskStatus.CANCELED:
        return AppColors.SecondaryText;
      case TaskStatus.COMPLETED:
        return AppColors.White;
      case TaskStatus.UNDEVELOPED:
        return AppColors.SecondaryText;
      case TaskStatus.DUE_DATE_COMMING:
        return AppColors.SecondaryText;
      case TaskStatus.LATE_DEADLINE:
        return AppColors.SecondaryText;
    }
    return AppColors.SecondaryText;
  }

  String get textStatus {
    if (isImportant == true) {
      return AppStrings.task_important.tr;
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
}
