import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class ToastView extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const ToastView({Key? key, required this.message, required this.isSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw - 32.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.w), color: isSuccess ? AppColors.Green50 : AppColors.Red50),
      child: Row(
        children: [
          ImageDisplay(
            isSuccess ? Assets.ic_success : Assets.ic_error,
            width: 20.w,
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
              child: Text(
            message,
            style: isSuccess ? AppTextStyle.successToast : AppTextStyle.errorToast,
          ))
        ],
      ),
    );
  }
}
