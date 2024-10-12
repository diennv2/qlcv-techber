import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/task/report_item_view.dart';
import 'package:mobile_rhm/core/constants/task.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/data/model/response/task/bao_cao_cong_viec.dart';
import 'package:mobile_rhm/data/model/response/task/sub_task_progress_response.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../core/languages/keys.dart';
import '../../core/theme/text_theme.dart';
import '../../core/values/colors.dart';
import '../badge/badge.dart';
import 'task_key_value.dart';

class SubTaskItemView extends StatelessWidget {
  final SubTaskProgressResponse? detail;
  final List<Baocaocongviec>? baocaocongviec;
  final Function? onAttachOpen;
  final bool isAllowUpdate;
  final bool isAllowAddReport;
  final Function? onUpdateSubTask;
  final Function? onShowDetailReport;
  final Function? onAddReport;

  const SubTaskItemView(
      {super.key,
      required this.detail,
      this.baocaocongviec,
      this.onAttachOpen,
      this.onAddReport,
      required this.isAllowUpdate,
      required this.isAllowAddReport,
      this.onUpdateSubTask,
      this.onShowDetailReport});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(color: AppColors.White),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        dense: true,
        minVerticalPadding: 0,
        child: ExpansionTileItem(
          childrenPadding: EdgeInsets.zero,
          backgroundColor: AppColors.White,
          tilePadding: EdgeInsets.zero,
          isHasTopBorder: false,
          isHasBottomBorder: false,
          title: Container(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        child: TaskStatus.iconView(status: (detail?.status ?? -1)),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Text(
                          detail?.tencongviec ?? '',
                          style: AppTextStyle.medium_16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            detail?.motacongviec ?? '',
                            style: AppTextStyle.secondary14_Regular,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24.w),
                    child: Row(
                      children: [
                        Text(
                          '${AppStrings.deadline_label.tr}:',
                          style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                            child: Text(
                          (detail?.ngayhoanthanh ?? '').isNotNullOrEmpty ? detail!.ngayhoanthanh! : AppStrings.unknown_deadline.tr,
                          style: AppTextStyle.medium_14,
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskKeyValueView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  icon: Icons.home_work_outlined,
                  value: detail?.coquanname ?? 'Chưa gán',
                  name: AppStrings.subtask_head_office.tr,
                ),
                TaskKeyValueView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  icon: Icons.calendar_month,
                  value: detail?.ngaygiao ?? '',
                  name: AppStrings.subtask_assign_date.tr,
                ),
                TaskKeyValueView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  icon: Icons.calendar_month,
                  value: (detail?.ngayhoanthanh ?? '').isNotNullOrEmpty ? detail!.ngayhoanthanh! : AppStrings.unknown_deadline.tr,
                  name: AppStrings.deadline_label.tr,
                ),
                TaskKeyValueView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  icon: Icons.list,
                  value: detail?.motacongviec ?? '',
                  name: AppStrings.task_content.tr,
                ),
                (detail?.soluongbaocao == null || detail?.soluongbaocao == 0)
                    ? TaskKeyValueView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        icon: Icons.report_outlined,
                        value: AppStrings.task_report_empty.tr,
                        name: AppStrings.task_report.tr,
                        endIcon: isAllowAddReport
                            ? TouchableOpacity(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  onAddReport?.call();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 32.w),
                                  child: const Icon(
                                    Icons.add_circle_outline,
                                    color: AppColors.Primary,
                                  ),
                                ),
                              )
                            : null,
                      )
                    : ExpansionTileItem(
                        backgroundColor: AppColors.White,
                        tilePadding: EdgeInsets.zero,
                        isHasTopBorder: false,
                        isHasBottomBorder: false,
                        title: TaskKeyValueView(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          icon: Icons.report_outlined,
                          value: '${detail?.soluongbaocao}',
                          name: AppStrings.task_report.tr,
                          endIcon: isAllowAddReport
                              ? TouchableOpacity(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    onAddReport?.call();
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline,
                                    color: AppColors.Primary,
                                  ),
                                )
                              : null,
                        ),
                        children: [
                          ...(baocaocongviec ?? []).map((report) {
                            return ReportItemView(
                                onShowDetail: (rp) {
                                  onShowDetailReport?.call(rp);
                                },
                                report: report,
                                onAttachOpen: (link) {
                                  onAttachOpen?.call(link);
                                });
                          })
                        ],
                      ),
                TaskKeyValueView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  icon: Icons.account_circle_outlined,
                  value: detail?.nguoigiaoName ?? '',
                  name: AppStrings.task_user_create.tr,
                ),
                TaskKeyValueView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  icon: Icons.account_circle_outlined,
                  valueWidget: (detail?.nguoiphoihop ?? []).isNotEmpty
                      ? Wrap(
                          children: [
                            ...(detail?.nguoiphoihop ?? []).map((ep) {
                              String name = "${ep.ten ?? ''}, ";
                              if ((detail?.nguoiphoihop ?? []).indexOf(ep) == (detail?.nguoiphoihop ?? []).length - 1) {
                                name = ep.ten ?? '';
                              }
                              return Text(
                                name,
                                style: AppTextStyle.medium_14,
                              );
                            }),
                          ],
                        )
                      : Text(
                          AppStrings.task_not_assign.tr,
                          style: AppTextStyle.medium_14,
                        ),
                  name: AppStrings.task_user_phoi_hop.tr,
                ),
                TaskKeyValueView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  icon: Icons.info_outlined,
                  name: AppStrings.status_label.tr,
                  valueWidget: BadgeView(
                    status: detail?.status ?? 0,
                    text: detail?.statusText,
                  ),
                ),
                if (detail?.filedinhkem?.isNotEmpty == true)
                  TaskKeyValueView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    icon: Icons.attach_file,
                    name: AppStrings.report_attach.tr,
                    valueWidget: Wrap(
                      children: [
                        ...detail!.filedinhkem!.map((filedinhkem) {
                          return TouchableOpacity(
                              onTap: () {
                                onAttachOpen?.call(filedinhkem);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                decoration: BoxDecoration(color: AppColors.GrayLight, borderRadius: BorderRadius.circular(6)),
                                child: Text((filedinhkem ?? '').split('/').last,
                                    style: AppTextStyle.secondary14_Regular.copyWith(decoration: TextDecoration.underline, color: AppColors.Light)),
                              ));
                        })
                      ],
                    ),
                  ),
                SizedBox(
                  height: 12.h,
                ),
                if (isAllowUpdate)
                  Center(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: AppSolidButton(
                        text: AppStrings.btn_update.tr,
                        isDisable: false,
                        onPress: () {
                          onUpdateSubTask?.call(detail);
                        }),
                  )),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  color: AppColors.BorderPrimary,
                  height: 12.h,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
