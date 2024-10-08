import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart'; // Nếu bạn sử dụng flutter_screenutil cho kích thước động

class AppSolidButton extends StatelessWidget {
  final String text;
  final bool isDisable;
  final VoidCallback onPress; // Sử dụng VoidCallback cho callback không trả về gì
  final double? height;
  final double? width;
  final List<Color>? colors;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const AppSolidButton({
    Key? key,
    required this.text,
    required this.isDisable,
    required this.onPress,
    this.height,
    this.width,
    this.colors,
    this.padding,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sử dụng Material để giữ các hiệu ứng Material như sóng nước khi nhấn
    if (isDisable) {
      return Opacity(
        opacity: isDisable ? 0.4 : 1,
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
          padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),

          alignment: Alignment.center,
          // Căn giữa cho text
          child: Text(
            text,
            style: AppTextStyle.primaryButton, // Style mẫu, thay đổi theo nhu cầu
          ),
        ),
      );
    }
    return Material(
      color: Colors.transparent, // Xóa màu nền mặc định của Material
      child: InkWell(
        onTap: isDisable ? null : onPress, // Vô hiệu hóa nếu isDisable là true
        borderRadius: BorderRadius.circular(12.w), // Đồng bộ với borderRadius của Container
        child: Opacity(
          opacity: isDisable ? 0.4 : 1,
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
              height: height ?? 56.h,
              // Áp dụng chiều cao nếu có
              width: width,
              // Áp dụng chiều rộng nếu có
              padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),

              alignment: Alignment.center,
              // Căn giữa cho text
              child: AutoSizeText(
                text,
                style: textStyle ?? AppTextStyle.primaryButton, // Style mẫu, thay đổi theo nhu cầu
              ),
            ),
          ),
        ),
      ),
    );
  }
}
