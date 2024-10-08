import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';

import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final logic = Get.find<SplashLogic>();
  final state = Get.find<SplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      height: 1.0.sh,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.White, AppColors.White], // Màu mặc định nếu không truyền vào
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ImageDisplay(
        Assets.app_logo_flat,
        width: 0.6.sw,
      ),
    );
  }
}
