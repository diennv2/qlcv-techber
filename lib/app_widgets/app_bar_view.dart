import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class AppBarView extends AppBar {
  final String? appBarTitle;
  final Function? onClickBack;
  final String? icon;
  final double? width;
  final String? rightIcon;
  final double? rightWidth;
  final Function? onRightClick;
  final Widget? subTitle;
  final Widget? rightIconWidget;

  AppBarView(
      {Key? key,
      this.appBarTitle = '',
      this.onClickBack,
      this.icon,
      this.width,
      this.rightIcon,
      this.onRightClick,
      this.rightWidth,
      this.subTitle,
      this.rightIconWidget})
      : super(
            key: key,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: null,
            leadingWidth: 0,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: 52.h,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 4.w),
                      child: IconButton(
                        color: AppColors.Secondary,
                        onPressed: () {
                          if (onClickBack != null) {
                            onClickBack();
                          } else {
                            Get.back();
                          }
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                  ),
                  appBarTitle != null
                      ? Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(appBarTitle, style: AppTextStyle.coolDartSemi15), subTitle ?? Container()],
                          ),
                        )
                      : Container(),
                  rightIcon != null
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: TouchableOpacity(
                              onTap: () {
                                if (onRightClick != null) {
                                  onRightClick();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  rightIcon,
                                  width: rightWidth,
                                ),
                              )),
                        )
                      : Container(),
                  rightIconWidget != null
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: rightIconWidget,
                        )
                      : Container()
                ],
              ),
            ));
}
