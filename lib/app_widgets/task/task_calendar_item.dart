import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';

class TaskCalendarItemView extends StatelessWidget {
  final String name;
  final String? lanhdao;
  final String deadlineTime;
  final String startTime;
  final String nguoitao;
  final String nguoiduyet;
  final Function? onDetail;
  final bool isShowFull;

  const TaskCalendarItemView({
    super.key,
    required this.name,
    required this.deadlineTime,
    required this.nguoitao,
    required this.nguoiduyet,
    required this.startTime,
    required this.isShowFull,
    this.lanhdao,
    this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    Widget body = Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: const BoxDecoration(
        color: AppColors.White,
        border: Border(bottom: BorderSide(color: AppColors.Gray, width: 1)),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text('Tên công việc: ', style: AppTextStyle.medium_14),
                        Expanded(
                          child: Text(
                            name,
                            style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                          ),
                        ),
                      ],
                    ),
                    if (lanhdao != null && isShowFull)
                      Wrap(
                        children: [
                          Text('Lãnh đạo: ', style: AppTextStyle.medium_14),
                          Text(
                            lanhdao!,
                            style: AppTextStyle.regular_14.copyWith(color: AppColors.Red),
                          ),
                        ],
                      ),
                    if (lanhdao != null && isShowFull) SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text('Người tạo: ', style: AppTextStyle.medium_14),
                        Text(
                          nguoitao,
                          style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text('Người duyệt: ', style: AppTextStyle.medium_14),
                        Text(
                          nguoiduyet,
                          style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          deadlineTime,
                          style: AppTextStyle.secondary14_Regular.copyWith(color: AppColors.SecondaryText),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    if (isShowFull)
                      Row(
                        children: [
                          Text('Bắt đầu: ', style: AppTextStyle.medium_14),
                          SizedBox(width: 4.w),
                          Text(startTime, style: AppTextStyle.secondary14_Regular),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // Kiểm tra nếu `nguoiduyet` khác null hoặc không rỗng, vô hiệu hóa click
    if (nguoiduyet.isNotEmpty) {
      return body; // Không có sự kiện click
    }

    // Nếu click hoạt động
    return GestureDetector(
      onTap: () {
        onDetail?.call();
      },
      child: body,
    );
  }
}
