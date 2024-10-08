import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import 'border_view.dart';
import 'button_view.dart';

class BottomButtonView extends StatelessWidget {
  final String name;
  final bool isLoading;
  final bool? isDisable;
  final Function onClick;
  final bool? isShowBorder;
  final bool? style2;
  final TextStyle? activeTextStyle;
  final Color? activeBox;

  const BottomButtonView(
      {Key? key,
      required this.name,
      required this.isLoading,
      required this.onClick,
      this.isDisable,
      this.isShowBorder,
      this.style2 = false,
      this.activeTextStyle,
      this.activeBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.White,
      height: 100.h,
      child: Column(
        children: [
          isShowBorder != null && !isShowBorder! ? Container() : BorderView(),
          SizedBox(
            height: 16.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 36.h),
            child: ButtonView(
              text: name,
              onClick: () {
                onClick();
              },
              isDisable: isDisable != null && isDisable! ? isDisable : isLoading,
              isLoading: isLoading,
              style2: style2,
              activeBox: activeBox,
              activeTextStyle: activeTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
