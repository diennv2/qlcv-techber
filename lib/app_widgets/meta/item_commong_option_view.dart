import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../data/model/common/opttion_model.dart';

class ItemCommonOptionView extends StatelessWidget {
  final OptionModel data;
  final Function onSelect;
  final bool isChecked;

  const ItemCommonOptionView({super.key, required this.data, required this.onSelect, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        Get.back();
        onSelect(data);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: const BoxDecoration(color: AppColors.White, border: Border(bottom: BorderSide(color: AppColors.BorderPrimary, width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                data.value ?? '',
                style: AppTextStyle.medium_16,
              ),
            ),
            if (isChecked)
              ImageDisplay(
                Assets.ic_check_circle,
                width: 20.w,
              )
          ],
        ),
      ),
    );
  }
}
