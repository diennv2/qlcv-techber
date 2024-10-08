import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class NotificationButton extends StatelessWidget {
  final bool hasNewArrive;
  final VoidCallback onPress;

  const NotificationButton({Key? key, required this.hasNewArrive, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        onPress.call();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w), color: AppColors.SecondaryButton),
        width: 40.w,
        height: 40.w,
        child: Stack(
          children: [
            ImageDisplay(
              Assets.ic_bell,
              width: 24.w,
            ),
            if (hasNewArrive)
              Positioned(
                right: 4,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: AppColors.Primary, borderRadius: BorderRadius.circular(4)),
                ),
              )
          ],
        ),
      ),
    );
  }
}
