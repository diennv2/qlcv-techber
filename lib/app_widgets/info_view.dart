import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class InfoView extends StatelessWidget {
  final String message;
  final String icon;

  const InfoView({Key? key, required this.message, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.Dialog,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            color: AppColors.White,
            width: 33.w,
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.white17Regular,
          )
        ],
      ),
    );
  }
}
