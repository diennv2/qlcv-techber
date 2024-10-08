import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class ItemIconKeyValue extends StatelessWidget {
  final String icon;
  final String text;
  final String keyValue;

  const ItemIconKeyValue({Key? key, required this.icon, required this.text, required this.keyValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.White,
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageDisplay(
            icon,
            width: 20.w,
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.BorderPrimary, width: 1))),
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    keyValue,
                    style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    text,
                    style: AppTextStyle.semi_bold_14,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
