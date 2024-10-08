import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import '../../core/values/assets.dart';

class EmptyView extends StatelessWidget {
  final String? text;
  final String? icon;

  const EmptyView({Key? key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageDisplay(
            icon ?? Assets.ic_survey_empty,
            height: 80.h,
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            text ?? AppStrings.common_empty.tr,
            style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
          ),
        ],
      ),
    );
  }
}
