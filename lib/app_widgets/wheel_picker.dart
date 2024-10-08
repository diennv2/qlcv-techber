import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/button/app_solid_button.dart';
import 'package:mobile_rhm/app_widgets/item_gender_view.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import 'image_display.dart';

class WheelPicker extends StatelessWidget {
  final List<WheelChoice> aChoices;
  final Function onChoiceChanged;
  final String title;
  final int? startPosition;
  var selectedWheel;

  WheelPicker({Key? key, required this.aChoices, required this.onChoiceChanged, required this.title, this.startPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogUtils.logE(message: 'Start pos = $startPosition');
    var wheelCustom = WheelChooser.custom(
        startPosition: startPosition,
        onValueChanged: (value) {
          LogUtils.logE(message: 'onValueChanged');
          LogUtils.log(value);
          selectedWheel = aChoices.elementAt(value);
        },
        onChoiceChanged: (value) {
          LogUtils.logE(message: 'onChoiceChanged');
          LogUtils.log(value);
          selectedWheel = value;
        },
        children: aChoices.map((choice) => ItemGenderView(name: choice.title)).toList());
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w)), color: AppColors.White),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  TouchableOpacity(
                      onTap: () {
                        Get.back();
                      },
                      child: ImageDisplay(
                        Assets.ic_close,
                        width: 40.w,
                      )),
                  Expanded(
                      child: Text(
                    title,
                    style: AppTextStyle.title,
                    textAlign: TextAlign.center,
                  )),
                  Container(
                    width: 40.w,
                  )
                ],
              ),
            ),
            SizedBox(height: 100.h, child: wheelCustom),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: AppSolidButton(
                  text: AppStrings.btn_ok.tr,
                  isDisable: false,
                  onPress: () {
                    Get.back();
                    selectedWheel ??= aChoices.first;
                    onChoiceChanged.call(selectedWheel);
                  }),
            )
          ],
        ));
  }
}
