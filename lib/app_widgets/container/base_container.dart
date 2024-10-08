import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/hide_keyboard.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class BaseContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final String? backIcon;
  final VoidCallback? onBackPress;
  final Color? fillColor;
  final EdgeInsetsGeometry? margin;

  const BaseContainer({Key? key, required this.title, required this.child, this.backIcon, this.onBackPress, this.fillColor, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HideKeyBoard(
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w)), color: fillColor ?? AppColors.White),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  if (backIcon.isNotNullOrBlank)
                    TouchableOpacity(
                        onTap: () {
                          onBackPress?.call();
                        },
                        child: ImageDisplay(
                          backIcon!,
                          width: 40.w,
                        )),
                  Expanded(
                      child: Text(
                    title,
                    style: AppTextStyle.title,
                    textAlign: TextAlign.center,
                  )),
                  if (backIcon.isNotNullOrBlank)
                    Container(
                      width: 40.w,
                    )
                ],
              ),
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }
}
