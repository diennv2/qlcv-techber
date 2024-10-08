import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/button/secondary_button.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class WarningView extends StatelessWidget {
  final String title;
  final String? descriptions;
  final String? negativeText;
  final String? positiveText;
  final Function onPositive;
  final Function? onNegative;
  final Widget? icon;

  const WarningView(
      {Key? key, required this.title, required this.onPositive, this.descriptions, this.negativeText, this.positiveText, this.onNegative, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: AppColors.White,
                border: Border.all(color: Colors.transparent),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x30000000),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: Column(
              children: [
                icon ?? Container(),
                title != ''
                    ? Text(
                        title,
                        style: AppTextStyle.semi_bold_20,
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                title != ''
                    ? SizedBox(
                        height: 8.h,
                      )
                    : Container(),
                if (descriptions.isNotNullOrEmpty)
                  Text(
                    descriptions ?? '',
                    style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                    textAlign: TextAlign.center,
                  ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                          height: 56.h,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          text: negativeText ?? AppStrings.btn_cancel.tr,
                          onPress: () {
                            Get.back();
                            if (onNegative != null) {
                              onNegative!.call();
                            }
                          }),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: AppSolidButton(
                          height: 56.h,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          text: positiveText ?? AppStrings.btn_ok.tr,
                          isDisable: false,
                          onPress: () {
                            Get.back();
                            onPositive.call();
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
