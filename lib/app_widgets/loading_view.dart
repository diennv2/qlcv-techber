import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class LoadingView extends StatelessWidget {
  final String? message;

  const LoadingView({Key? key, this.message}) : super(key: key);

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
          const CircularProgressIndicator(
            strokeWidth: 1,
            color: AppColors.White,
          ),
          SizedBox(
            height: 8.h,
          ),
          message != null
              ? Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.white17Regular,
                )
              : Container()
        ],
      ),
    );
  }
}
