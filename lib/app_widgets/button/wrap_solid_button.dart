import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/values/colors.dart'; // Nếu bạn sử dụng flutter_screenutil cho kích thước động

class WrapSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress; // Sử dụng VoidCallback cho callback không trả về gì
  final bool? isDisable;
  final double? height;
  final List<Color>? colors;

  const WrapSolidButton({
    Key? key,
    required this.text,
    required this.isDisable,
    required this.onPress,
    this.height,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sử dụng Material để giữ các hiệu ứng Material như sóng nước khi nhấn
    var textS = DeviceUtils.textSize(text, AppTextStyle.primaryButtonSmall);
    var width = textS.width + 48.w;
    if (isDisable == true) {
      return Opacity(
        opacity: isDisable == true ? 0.4 : 1,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors ?? [AppColors.PrimaryGradientButton, AppColors.SecondaryGradientButton], // Màu mặc định nếu không truyền vào
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12.w),
          ),
          height: height ?? 56.h,
          // Áp dụng chiều cao nếu có
          width: width,
          // Áp dụng chiều rộng nếu có
          padding: EdgeInsets.symmetric(horizontal: 16.w),

          alignment: Alignment.center,
          // Căn giữa cho text
          child: AutoSizeText(
            text,
            style: AppTextStyle.primaryButton, // Style mẫu, thay đổi theo nhu cầu
          ),
        ),
      );
    }
    return Material(
      color: Colors.transparent, // Xóa màu nền mặc định của Material
      child: InkWell(
        onTap: isDisable == true ? null : onPress, // Vô hiệu hóa nếu isDisable là true
        borderRadius: BorderRadius.circular(12.w), // Đồng bộ với borderRadius của Container
        child: Opacity(
          opacity: isDisable == true ? 0.4 : 1,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors ?? [AppColors.PrimaryGradientButton, AppColors.SecondaryGradientButton], // Màu mặc định nếu không truyền vào
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Container(
              height: height ?? 40.h,
              // Áp dụng chiều cao nếu có
              width: width,
              // Áp dụng chiều rộng nếu có
              padding: EdgeInsets.symmetric(horizontal: 16.w),

              alignment: Alignment.center,
              // Căn giữa cho text
              child: AutoSizeText(
                text,
                style: AppTextStyle.primaryButton.copyWith(fontSize: 14.sp), // Style mẫu, thay đổi theo nhu cầu
              ),
            ),
          ),
        ),
      ),
    );
  }
}
