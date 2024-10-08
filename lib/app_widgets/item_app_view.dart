import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'image_display.dart';

class ItemAppView extends StatelessWidget {
  final Function onClickItem;
  final dynamic item;

  const ItemAppView({super.key, required this.onClickItem, required this.item});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        onClickItem.call(item);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: ImageDisplay(
                item['icon'],
                width: 48,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['name'],
                    style: AppTextStyle.medium_16,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    item['description'],
                    style: AppTextStyle.regular_12.copyWith(color: AppColors.SecondaryText),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
