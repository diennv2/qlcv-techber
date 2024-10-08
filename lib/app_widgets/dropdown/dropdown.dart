import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class DropDownView extends StatelessWidget {
  final String? value;
  final String label;
  final String hint;
  final bool? isDisable;
  final Function onPress;
  final String? errorText;
  final bool? required;
  RxBool isSelecting = false.obs;
  RxString icon = Assets.ic_caret_down.obs;

  DropDownView({Key? key, required this.label, this.value, required this.hint, required this.onPress, this.isDisable, this.errorText, this.required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = AppColors.White;

    TextStyle textStyle = AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText);
    if (value.isNotNullOrBlank || errorText.isNotNullOrBlank) {
      textStyle = AppTextStyle.regular_14;
    }
    if (value.isNotNullOrBlank || isSelecting.value) {
      icon = Assets.ic_caret_up.obs;
    }
    if (isDisable == true) {
      bgColor = AppColors.BgInputDisable;
    } else if (isSelecting.value) {
      bgColor = AppColors.BgInputFocus;
    } else if (errorText.isNotNullOrBlank) {
      bgColor = AppColors.White;
    }
    return TouchableOpacity(
      activeOpacity: isDisable == true ? 0.2 : 1,
      onTap: () async {
        if (isDisable == true) {
          return;
        }
        FocusScope.of(context).unfocus();
        isSelecting.value = true;
        icon = Assets.ic_caret_up.obs;
        LogUtils.logE(message: 'Start select');
        await onPress.call();
        LogUtils.logE(message: 'End select');
        if (value.isNotNullOrBlank) {
          icon = Assets.ic_caret_up.obs;
        } else {
          icon = Assets.ic_caret_down.obs;
        }
        isSelecting.value = false;
        if (isDisable == true) {
          bgColor = AppColors.BgInputDisable;
        } else if (isSelecting.value) {
          bgColor = AppColors.BgInputFocus;
        } else if (errorText.isNotNullOrBlank) {
          bgColor = AppColors.White;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(style: AppTextStyle.medium_14, children: [
            TextSpan(text: label),
            if (required == true) TextSpan(text: ' *', style: AppTextStyle.medium_14.copyWith(color: AppColors.ErrorText)),
          ])),
          SizedBox(height: 8.h),
          Obx(() {
            isSelecting.value;
            if (isDisable == true) {
              bgColor = AppColors.BgInputDisable;
            } else if (isSelecting.value) {
              LogUtils.logE(message: 'AppColors.BgInputFocus');
              bgColor = AppColors.BgInputFocus;
            } else if (errorText.isNotNullOrBlank) {
              bgColor = AppColors.White;
            } else {
              bgColor = AppColors.White;
            }
            LogUtils.logE(message: 'isSelecting.value = ${isSelecting.value}');
            return Container(
              padding: EdgeInsets.only(left: 16.w),
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
                border: Border.all(
                  color: errorText.isNotNullOrBlank ? AppColors.BorderError : (isSelecting.value ? AppColors.BorderFocus : AppColors.BorderPrimary),
                  width: 1,
                ),
                color: bgColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value.isNotNullOrBlank ? value! : hint,
                      style: textStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 48.w,
                    height: 48.h,
                    alignment: Alignment.center,
                    child: Obx(() {
                      return ImageDisplay(
                        icon.value,
                        width: 20.w,
                      );
                    }),
                  )
                ],
              ),
            );
          }),
          if (errorText.isNotNullOrBlank)
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                errorText!,
                style: AppTextStyle.errorLabel,
              ),
            )
        ],
      ),
    );
  }
}
