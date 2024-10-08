import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/response/task/danh_gia_bao_cao.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../core/languages/keys.dart';
import '../../core/theme/text_theme.dart';
import '../../data/model/response/task/bao_cao_cong_viec.dart';
import 'task_key_value.dart';

class ReviewItemView extends StatelessWidget {
  final Danhgiabaocao? review;
  final Color? backgroundColor;
  final Function onOpenAttach;

  const ReviewItemView({super.key, required this.review, this.backgroundColor, required this.onOpenAttach});

  @override
  Widget build(BuildContext context) {
    if (review == null) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(color: backgroundColor ?? AppColors.GrayLight, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskKeyValueView(
            icon: Icons.account_circle_outlined,
            value: review!.nguoidanhgia ?? '',
            name: AppStrings.user_review_label.tr,
          ),
          TaskKeyValueView(
            icon: Icons.date_range_outlined,
            value: review!.thoigiandanhgia ?? '',
            name: AppStrings.review_time.tr,
          ),
          TaskKeyValueView(
            icon: Icons.content_paste,
            value: review!.noidungdanhgia ?? '',
            name: AppStrings.report_content.tr,
          ),
          if (review!.filedinhkem.isNotNullOrEmpty)
            TaskKeyValueView(
              icon: Icons.attach_file,
              valueWidget: TouchableOpacity(
                onTap: () {
                  onOpenAttach?.call(review!.filedinhkem);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(color: AppColors.GrayLight, borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_file),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: Text((review!.filedinhkem ?? '').split('/').last,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.secondary14_Regular.copyWith(decoration: TextDecoration.underline, color: AppColors.Light)),
                      ),
                    ],
                  ),
                ),
              ),
              name: AppStrings.report_attach.tr,
            ),
        ],
      ),
    );
  }
}
