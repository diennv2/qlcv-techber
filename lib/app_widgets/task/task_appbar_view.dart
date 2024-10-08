import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../core/values/colors.dart';

class TaskAppBarView extends StatelessWidget {
  final String name;
  final num status;
  final String statusLabel;
  final bool? isImportant;
  final Function? onChangeStatus;

  const TaskAppBarView({super.key, required this.name, required this.status, required this.statusLabel, this.isImportant, this.onChangeStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: name,
                  style: AppTextStyle.medium_20,
                ),
                if (isImportant == true)
                  TextSpan(
                    text: " <${AppStrings.task_important.tr}>",
                    style: AppTextStyle.medium_16.copyWith(color: Colors.deepOrange),
                  ),
              ],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 8.h,
          ),
          TouchableOpacity(
            activeOpacity: onChangeStatus != null ? 0.2 : 1,
            onTap: () {
              onChangeStatus?.call();
            },
            child: Row(
              children: [
                TaskStatus.iconView(status: status),
                SizedBox(
                  width: 8.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.status_label.tr,
                      style: AppTextStyle.regular_16.copyWith(color: AppColors.SecondaryText),
                    ),
                    Text(
                      statusLabel,
                      style: AppTextStyle.medium_16.copyWith(color: TaskStatus.textColorByStatus(status: status)),
                    )
                  ],
                ),
                if (onChangeStatus != null) const Icon(Icons.arrow_drop_down)
              ],
            ),
          )
        ],
      ),
    );
  }
}
