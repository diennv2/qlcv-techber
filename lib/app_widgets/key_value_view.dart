import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';

class KeyValueView extends StatelessWidget {
  final String label;
  final String? value;
  final EdgeInsetsGeometry? margin;

  const KeyValueView({Key? key, required this.label, this.value, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      margin: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.secondary14_Regular,
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            value ?? '',
            style: AppTextStyle.semi_bold_14,
          ),
        ],
      ),
    );
  }
}
