import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/task/task_key_value.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/helpers.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/data/model/response/task/file_dinh_kem.dart';
import 'package:mobile_rhm/data/model/response/task/kho_khan_vuong_mac.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../core/values/colors.dart';
import '../../data/model/response/task/nguoi_nhan_viec.dart';
import '../../data/model/response/task/tien_do_cong_viec.dart';
import '../badge/badge.dart';

class TaskOverViewSection extends StatelessWidget {
  final String name;
  final List<String> departments;
  final String? phutrach;
  final String? lanhdao;
  final String deadlineTime;
  final String startTime;
  final String statusText;
  final List<Nguoinhanviec> employee;
  final String typeOfWork;
  final Tiendocongviec? workProgress;
  final int khoKhanCount;
  final num status;
  final Function? onDetail;
  final bool? isWarningDeadlineTime;
  final String? deadlineTimeTextColor;
  final List<Khokhanvuongmac>? khokhaDes;
  final List<FileDinhKem>? fileDinhKems;
  final Function? onOpenAttach;
  final bool? isImportant;
  final Decoration? decoration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const TaskOverViewSection({
    super.key,
    required this.name,
    required this.departments,
    required this.deadlineTime,
    required this.status,
    required this.statusText,
    required this.employee,
    required this.startTime,
    required this.khoKhanCount,
    required this.typeOfWork,
    required this.workProgress,
    this.onDetail,
    this.onOpenAttach,
    this.fileDinhKems,
    this.isImportant,
    this.decoration,
    this.padding,
    this.margin,
    this.phutrach,
    this.lanhdao,
    this.isWarningDeadlineTime,
    this.khokhaDes,
    this.deadlineTimeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    LogUtils.logE(message: 'Status is $status');
    Widget body = Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 8.w),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: decoration ?? const BoxDecoration(color: AppColors.White, border: Border(bottom: (BorderSide(color: AppColors.Gray, width: 1)))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.task_general.tr,
            style: AppTextStyle.medium_16,
          ),
          SizedBox(
            height: 12.h,
          ),
          TaskKeyValueView(
            icon: Icons.calendar_today_outlined,
            name: AppStrings.deadline_from_label.tr,
            value: startTime,
          ),
          TaskKeyValueView(
            icon: Icons.calendar_today_outlined,
            name: AppStrings.deadline_label.tr,
            valueWidget: Text(
              deadlineTime,
              style: AppTextStyle.medium_14
                  .copyWith(color: deadlineTimeTextColor != null ? CommonUtils.hexToColor(hexString: deadlineTimeTextColor) : AppColors.PrimaryText),
            ),
          ),
          if (phutrach.isNotNullOrEmpty)
            TaskKeyValueView(
              icon: Icons.account_circle_outlined,
              name: AppStrings.phutrach_label.tr,
              valueWidget: Wrap(
                children: [
                  Text(
                    phutrach ?? '',
                    style: AppTextStyle.medium_14,
                  ),
                ],
              ),
            ),
          if (departments.isNotEmpty)
            TaskKeyValueView(
              icon: Icons.account_balance_outlined,
              name: AppStrings.phongban_label.tr,
              valueWidget: Wrap(
                children: [
                  ...departments.map((de) {
                    String name = "${de ?? ''}, ";
                    if (departments.indexOf(de) == departments.length - 1) {
                      name = de ?? '';
                    }
                    return Text(
                      name,
                      style: AppTextStyle.medium_14,
                    );
                  })
                ],
              ),
            ),
          if (employee.isNotEmpty)
            TaskKeyValueView(
              icon: Icons.account_circle_outlined,
              name: AppStrings.thuc_hien_label.tr,
              valueWidget: Wrap(
                children: [
                  ...employee.map((ep) {
                    String name = "${ep.ten ?? ''}, ";
                    if (employee.indexOf(ep) == employee.length - 1) {
                      name = ep.ten ?? '';
                    }
                    return Text(
                      name,
                      style: AppTextStyle.medium_14
                          .copyWith(color: ep.textColor.isNotNullOrEmpty ? CommonUtils.hexToColor(hexString: ep.textColor) : AppColors.PrimaryText),
                    );
                  }),
                ],
              ),
            ),
          TaskKeyValueView(
            icon: Icons.workspaces_outline,
            name: AppStrings.task_type_label.tr,
            value: typeOfWork,
          ),
          if (lanhdao != null)
            TaskKeyValueView(
              icon: Icons.account_circle_outlined,
              name: AppStrings.lanhdao_label.tr,
              valueWidget: Wrap(
                children: [
                  Text(
                    lanhdao ?? '',
                    style: AppTextStyle.medium_14.copyWith(color: AppColors.Red),
                  ),
                ],
              ),
            ),
          if (khokhaDes != null && khokhaDes!.isNotEmpty)
            TaskKeyValueView(
                icon: Icons.local_fire_department_outlined,
                name: AppStrings.kho_khan_label.tr,
                valueWidget: Wrap(
                  children: [
                    ...khokhaDes!.map((ep) {
                      int index = khokhaDes!.indexOf(ep);
                      String name = "${index + 1}, ${ep.noidung ?? ''}\n ";

                      return Text(name, style: AppTextStyle.medium_14.copyWith(color: Colors.orange));
                    }),
                  ],
                )),
          TaskKeyValueView(
              icon: Icons.info_outlined,
              name: AppStrings.status_label.tr,
              valueWidget: BadgeView(
                status: status,
              )),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );

    if (onDetail == null) {
      return body;
    }
    return TouchableOpacity(
      onTap: () {
        onDetail?.call();
      },
      child: body,
    );
  }
}
