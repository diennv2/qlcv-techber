import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/helpers.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/data/model/response/task/file_dinh_kem.dart';
import 'package:mobile_rhm/data/model/response/task/kho_khan_vuong_mac.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../core/values/colors.dart';
import '../../data/model/response/task/nguoi_nhan_viec.dart';
import '../../data/model/response/task/tien_do_cong_viec.dart';
import '../badge/badge.dart';

class TaskMainItemView extends StatelessWidget {
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
  final bool isShowFull;

  const TaskMainItemView({
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
    required this.isShowFull,
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
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: decoration ?? const BoxDecoration(color: AppColors.White, border: Border(bottom: (BorderSide(color: AppColors.Gray, width: 1)))),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 4.h),
                child: TaskStatus.iconView(status: status),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyle.medium_16.copyWith(color: TaskStatus.textColorByStatus(status: status)),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    if (lanhdao.isNotNullOrEmpty && isShowFull)
                      Wrap(
                        children: [
                          Text(
                            '${AppStrings.lanhdao_label.tr}: ',
                            style: AppTextStyle.medium_14,
                          ),
                          Text(
                            lanhdao!,
                            style: AppTextStyle.regular_14.copyWith(color: AppColors.Red),
                          ),
                        ],
                      ),
                    if (lanhdao.isNotNullOrEmpty && isShowFull)
                      SizedBox(
                        height: 4.h,
                      ),
                    if (phutrach.isNotNullOrEmpty && isShowFull)
                      Wrap(
                        children: [
                          Text(
                            '${AppStrings.phutrach_label.tr}: ',
                            style: AppTextStyle.medium_14,
                          ),
                          Text(
                            phutrach!,
                            style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                          ),
                        ],
                      ),
                    if (phutrach.isNotNullOrEmpty)
                      SizedBox(
                        height: 4.h,
                      ),
                    Wrap(
                      children: [
                        Text(
                          '>> ',
                          style: AppTextStyle.medium_14,
                        ),
                        ...departments.map((de) {
                          String name = "${de ?? ''}, ";
                          if (departments.indexOf(de) == departments.length - 1) {
                            name = de ?? '';
                          }
                          return Text(
                            name,
                            style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                          );
                        })
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    if (employee.isNotEmpty && isShowFull)
                      Wrap(
                        children: [
                          Text(
                            '${AppStrings.thuc_hien_label.tr}: ',
                            style: AppTextStyle.medium_14,
                          ),
                          ...employee.map((ep) {
                            String name = "${ep.ten ?? ''}, ";
                            if (employee.indexOf(ep) == employee.length - 1) {
                              name = ep.ten ?? '';
                            }
                            return Text(
                              name,
                              style: AppTextStyle.regular_14.copyWith(
                                  color: ep.textColor.isNotNullOrEmpty ? CommonUtils.hexToColor(hexString: ep.textColor) : AppColors.SecondaryText),
                            );
                          }),
                        ],
                      ),
                    if (employee.isNotEmpty && isShowFull)
                      SizedBox(
                        height: 4.h,
                      ),
                    if (isShowFull)
                      Row(
                        children: [
                          Text(
                            '${AppStrings.task_type_label.tr}: ',
                            style: AppTextStyle.medium_14,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(typeOfWork, style: AppTextStyle.secondary14_Regular)
                        ],
                      ),
                    SizedBox(
                      height: 4.h,
                    ),
                    if (isShowFull)
                      Row(
                        children: [
                          Text(
                            '${AppStrings.deadline_from_label.tr}: ',
                            style: AppTextStyle.medium_14,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(startTime, style: AppTextStyle.secondary14_Regular)
                        ],
                      ),
                    if (isShowFull)
                      SizedBox(
                        height: 4.h,
                      ),
                    Row(
                      children: [
                        // Text(
                        //   '${AppStrings.deadline_label.tr}: ',
                        //   style: AppTextStyle.medium_14,
                        // ),
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          deadlineTime,
                          style: AppTextStyle.secondary14_Regular.copyWith(
                              color:
                                  deadlineTimeTextColor != null ? CommonUtils.hexToColor(hexString: deadlineTimeTextColor) : AppColors.SecondaryText),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    if (isShowFull)
                      if (khokhaDes != null && khokhaDes!.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                          decoration: BoxDecoration(color: AppColors.GrayLight, borderRadius: BorderRadius.circular(12)),
                          child: Wrap(
                            children: [
                              Text(
                                '${AppStrings.kho_khan_label.tr}: ',
                                style: AppTextStyle.medium_14.copyWith(color: Colors.orange),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              ...khokhaDes!.map((ep) {
                                int index = khokhaDes!.indexOf(ep);
                                String name = "${index + 1}, ${ep.noidung ?? ''}\n ";

                                return Text(name, style: AppTextStyle.regular_14);
                              }),
                            ],
                          ),
                        ),
                    if (fileDinhKems != null && fileDinhKems!.isNotEmpty && isShowFull)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                        margin: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(color: AppColors.GrayLight, borderRadius: BorderRadius.circular(12)),
                        child: Wrap(
                          children: [
                            Text(
                              '${AppStrings.report_attach.tr} ',
                              style: AppTextStyle.medium_14,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            ...fileDinhKems!.map((ep) {
                              return TouchableOpacity(
                                onTap: () {
                                  onOpenAttach?.call(ep);
                                },
                                child: Text(ep.url ?? '',
                                    style: AppTextStyle.secondary14_Regular.copyWith(decoration: TextDecoration.underline, color: AppColors.Light)),
                              );
                            }),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (isImportant == true)
            Positioned(
                right: 0,
                top: 0,
                child: ImageDisplay(
                  Assets.ic_flag,
                  width: 12.w,
                  color: Colors.red,
                ))
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
