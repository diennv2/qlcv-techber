import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../core/values/colors.dart';

class FilterDropDownView extends StatelessWidget {
  final bool countSelected;
  final Function onPress;
  final String label;

  const FilterDropDownView({super.key, required this.countSelected, required this.onPress, required this.label});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        onPress.call();
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.Border),
            color: countSelected == false ? AppColors.White : AppColors.Primary.withOpacity(0.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyle.regular_12,
            ),
            const Icon(Icons.arrow_drop_down_sharp)
          ],
        ),
      ),
    );
  }
}
