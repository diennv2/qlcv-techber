import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class TaskKeyValueView extends StatelessWidget {
  final IconData icon;
  final String name;
  final String? value;
  final Widget? valueWidget;
  final EdgeInsetsGeometry? padding;
  final Widget? endIcon;

  const TaskKeyValueView({super.key, required this.icon, required this.name, this.value, this.valueWidget, this.padding, this.endIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(
            icon,
            weight: 24.w,
            color: AppColors.DarkGray,
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: AppTextStyle.regular_14.copyWith(color: AppColors.SecondaryText),
                    ),
                  ),
                  endIcon ?? const SizedBox.shrink()
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              value != null
                  ? Text(
                      value!,
                      style: AppTextStyle.medium_14,
                    )
                  : valueWidget ?? Container(),
              SizedBox(
                height: 12.h,
              ),
              const Divider(
                height: 1,
                color: AppColors.DividerColor,
              )
            ],
          )),
        ],
      ),
    );
  }
}
