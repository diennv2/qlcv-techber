import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/button/wrap_secondary_button.dart';
import 'package:mobile_rhm/app_widgets/checkbox/checkbox_view.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class WelcomBoxView extends StatelessWidget {
  final VoidCallback onLater;
  final VoidCallback onChangePassword;
  final Function onDontShowAgainChange;
  final String userName;

  const WelcomBoxView({Key? key, required this.onLater, required this.onChangePassword, required this.onDontShowAgainChange, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: ImageDisplay(
              Assets.welcome_box,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              color: AppColors.White,
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.welcome_user.trParams({'user': userName}),
                  style: AppTextStyle.bold_20,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  AppStrings.welcome_user_des.tr,
                  style: AppTextStyle.secondaryText,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CheckBoxView(
                    label: AppStrings.dont_show_info_again.tr,
                    onCheckChange: (label, value) {
                      onDontShowAgainChange.call(value);
                    },
                    initState: false),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    WrapSecondaryButton(
                      text: AppStrings.btn_later.tr,
                      onPress: () {
                        Get.back();
                        onLater.call();
                      },
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                        child: AppSolidButton(
                      text: AppStrings.btn_change_password.tr,
                      onPress: () {
                        Get.back();
                        onChangePassword.call();
                      },
                      isDisable: false,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
