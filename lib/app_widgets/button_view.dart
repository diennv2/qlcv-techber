import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ButtonView extends StatelessWidget {
  final String text;
  final Function onClick;
  final bool? isDisable;
  final bool? isLoading;
  final bool? style2;
  final TextStyle? activeTextStyle;
  final Color? activeBox;

  const ButtonView(
      {Key? key,
      required this.text,
      required this.onClick,
      this.isDisable = false,
      this.isLoading = false,
      this.style2 = false,
      this.activeTextStyle,
      this.activeBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        if (!isLoading! && !isDisable!) {
          onClick();
        }
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: 46.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                color: isDisable! || isLoading! || style2! ? AppColors.GrayLight : activeBox ?? AppColors.Primary),
            child: Text(
              text,
              style: isDisable! || isLoading!
                  ? AppTextStyle.grayLightSemi15
                  : style2!
                      ? AppTextStyle.primarySemi15
                      : activeTextStyle ?? AppTextStyle.whiteBold14,
            ),
          ),
          isLoading!
              ? Positioned.fill(
                  left: 10.w,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.White,
                          strokeWidth: 1,
                        )),
                  ))
              : Container()
        ],
      ),
    );
  }
}
