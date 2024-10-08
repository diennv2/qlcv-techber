import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/empty_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/data/model/response/task/file_dinh_kem.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class TaskFileAttachmentSection extends StatelessWidget {
  final List<FileDinhKem>? fileDinhKems;
  final Function? onOpenAttach;
  final Function? onAddAttach;
  final EdgeInsetsGeometry? padding;
  final bool isAllowAddAttach;

  const TaskFileAttachmentSection(
      {super.key, required this.fileDinhKems, this.onOpenAttach, this.onAddAttach, this.padding, required this.isAllowAddAttach});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.report_attach.tr,
                  style: AppTextStyle.medium_16,
                ),
              ),
              if (isAllowAddAttach)
                TouchableOpacity(
                  child: const Icon(
                    Icons.add_circle_outline,
                  ),
                  onTap: () {
                    if (isAllowAddAttach) {
                      onAddAttach?.call();
                    }
                  },
                )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          if ((fileDinhKems ?? []).isNotEmpty)
            ...(fileDinhKems ?? []).map((ep) {
              return TouchableOpacity(
                onTap: () {
                  onOpenAttach?.call(ep.url);
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
                        child: Text((ep.url ?? '').split('/').last,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.secondary14_Regular.copyWith(decoration: TextDecoration.underline, color: AppColors.Light)),
                      ),
                    ],
                  ),
                ),
              );
            }),
          if ((fileDinhKems ?? []).isEmpty) const EmptyView()
        ],
      ),
    );
  }
}
