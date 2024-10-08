import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../core/languages/keys.dart';
import '../../core/theme/text_theme.dart';
import '../../data/model/response/task/bao_cao_cong_viec.dart';
import 'task_key_value.dart';

class ReportItemView extends StatelessWidget {
  final Baocaocongviec? report;
  final Function onAttachOpen;
  final Function? onShowDetail;
  final bool? isShowFullReport;
  final Color? backgroundColor;

  const ReportItemView({super.key, required this.report, required this.onAttachOpen, this.isShowFullReport, this.onShowDetail, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    if (report == null) {
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
          if (isShowFullReport == true)
            TaskKeyValueView(
              icon: Icons.account_circle_outlined,
              value: report!.nguoibaocaoName ?? '',
              name: AppStrings.user_report.tr,
            ),
          if (isShowFullReport == true)
            TaskKeyValueView(
              icon: Icons.date_range_outlined,
              value: report!.ngaybaocao ?? '',
              name: AppStrings.report_date.tr,
            ),
          TaskKeyValueView(
            icon: Icons.content_paste,
            value: report!.noidungbaocao ?? '',
            name: AppStrings.report_content.tr,
          ),
          TaskKeyValueView(
            icon: Icons.checklist,
            value: report!.ketquadatduoc ?? '',
            name: AppStrings.report_result.tr,
          ),
          TaskKeyValueView(
            icon: Icons.report_outlined,
            value: report?.isDadanhgia == true ? AppStrings.is_report_review.tr : AppStrings.is_report_not_review.tr,
            name: AppStrings.report_review.tr,
          ),
          const SizedBox(
            height: 4,
          ),
          if (isShowFullReport == true)
            if (report!.filedinhkem != null && report!.filedinhkem!.isNotEmpty)
              TaskKeyValueView(
                  icon: Icons.attach_file,
                  name: AppStrings.report_attach.tr,
                  valueWidget: TouchableOpacity(
                    onTap: () {
                      onAttachOpen.call(report!.filedinhkem);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      decoration: BoxDecoration(color: AppColors.White, borderRadius: BorderRadius.circular(6)),
                      child: Text((report?.filedinhkem ?? '').split('/').last,
                          style: AppTextStyle.secondary14_Regular.copyWith(decoration: TextDecoration.underline, color: AppColors.Light)),
                    ),
                  )),
          if (isShowFullReport != true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TouchableOpacity(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      LogUtils.logE(message: 'Click report ${report?.noidungbaocao}');
                      LogUtils.logE(message: 'Baocaobosung: ${report?.baocaochitietbosung?.length}');
                      onShowDetail?.call(report);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Text(
                        AppStrings.btn_view_detail.tr,
                        style: AppTextStyle.medium_14.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ))
              ],
            )
        ],
      ),
    );
  }
}
