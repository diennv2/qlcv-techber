import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class BottomTabHighlightView extends StatelessWidget {
  final bool isSelected;

  const BottomTabHighlightView({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppColors.Primary,
                    AppColors.Primary,
                  ], // red to yellow
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            height: 4.h,
            width: 48.w,
          )
        : Container(
            height: 4.h,
            width: 48.w,
            color: Colors.transparent,
          );
  }
}
