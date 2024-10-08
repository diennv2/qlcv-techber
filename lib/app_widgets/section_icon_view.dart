import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';

class SectionIconView extends StatelessWidget {
  final String icon;
  final String text;

  const SectionIconView({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageDisplay(
          icon,
          height: 24.w,
        ),
        SizedBox(
          width: 12.w,
        ),
        Text(
          text,
          style: AppTextStyle.semi_bold_16,
        )
      ],
    );
  }
}
