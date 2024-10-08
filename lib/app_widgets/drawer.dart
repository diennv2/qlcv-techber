import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_services/story/rhm_service.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/routers/app_pages.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'image_display.dart';

Widget DrawerItem({required String icon, required String title, Function? onTap, bool? preventAllTouch}) {
  if (preventAllTouch != null && preventAllTouch) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      margin: EdgeInsets.symmetric(vertical: 16.w),
      child: TouchableOpacity(
        onTap: () {
          if (onTap != null) {
            Get.back();
            onTap();
          }
        },
        child: Row(
          children: [
            ImageDisplay(
              icon,
              width: 36.w,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              title,
              style: AppTextStyle.body_text,
            ),
          ],
        ),
      ),
    );
  }
  return TouchableOpacity(
    onTap: () {
      if (onTap != null) {
        Get.back();
        onTap();
      }
    },
    child: Container(
      color: Colors.transparent,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      margin: EdgeInsets.symmetric(vertical: 16.w),
      child: Row(
        children: [
          ImageDisplay(
            icon,
            width: 36.w,
          ),
          SizedBox(
            width: 12.w,
          ),
          Text(
            title,
            style: AppTextStyle.body_text,
          ),
        ],
      ),
    ),
  );
}

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final RHMService _rhmService = Get.find<RHMService>();

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Stack(
          children: [
            Positioned.fill(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.transparent),
            )),
            Container(
              margin: EdgeInsets.only(left: 16.w, bottom: 16.w, right: 84.w),
              width: 1.0.sw,
              height: 1.0.sh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: GestureDetector(
                  onTap: () {},
                  child: Drawer(
                    child: SizedBox(
                      width: 0.7.sw,
                      child: Column(
                        // Important: Remove any padding from the ListView.
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                height: 240.h,
                                width: 1.0.sw,
                                color: AppColors.Primary,
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: DrawerHeader(
                                  // margin: EdgeInsets.zero,
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.hi_label.tr,
                                        style: AppTextStyle.body_text.copyWith(color: AppColors.White),
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.perm_identity_outlined,
                                            color: AppColors.White,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            _rhmService.userService.getUserProfile()?.displayName ?? '',
                                            style: AppTextStyle.body_text.copyWith(color: AppColors.White),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.account_circle_outlined,
                                            color: AppColors.White,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            _rhmService.userService.getUserProfile()?.chucVuName ?? '',
                                            style: AppTextStyle.body_text.copyWith(color: AppColors.White),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.account_balance_outlined,
                                            color: AppColors.White,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            _rhmService.userService.getUserProfile()?.phongBanName ?? '',
                                            style: AppTextStyle.body_text.copyWith(color: AppColors.White),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              DrawerItem(
                                icon: Assets.ic_logout,
                                title: AppStrings.btn_logout.tr,
                                onTap: () {
                                  _rhmService.userService.logout();
                                  Get.offAllNamed(Routers.AUTH_LOGIN);
                                },
                                preventAllTouch: true,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.app_name.tr,
                                      style: AppTextStyle.semi_bold_14.copyWith(color: AppColors.LOGO),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
