import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class IconValueView extends StatelessWidget {
  final String icon;
  final String text;

  const IconValueView({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageDisplay(
          icon,
          width: 20.w,
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
          ),
        )
      ],
    );
  }
}
