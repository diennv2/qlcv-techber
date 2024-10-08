import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ItemNotificationView extends StatelessWidget {
  final String title;
  final String content;
  final bool isRead;
  final String timeAgo;
  final Function onDetail;

  const ItemNotificationView(
      {super.key, required this.title, required this.content, required this.isRead, required this.timeAgo, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    Color bgColor = isRead ? AppColors.White : AppColors.BgInputFocus;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(border: const Border(bottom: BorderSide(color: AppColors.DividerColor, width: 1)), color: bgColor),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyle.semi_bold_18,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Html(
                  data: content,
                  style: {
                    '#': Style(
                      fontSize: FontSize(14.sp),
                      margin: Margins.zero,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w400,
                    ),
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  timeAgo,
                  style: AppTextStyle.regular_12.copyWith(color: AppColors.Teritary),
                ),
              ],
            ),
          ),
          // ImageDisplay(
          //   Assets.ic_caret_right,
          //   width: 16.w,
          // )
        ],
      ),
    );
  }
}
