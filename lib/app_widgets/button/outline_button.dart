import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart'; // Nếu bạn sử dụng flutter_screenutil cho kích thước động

class AppOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress; // Sử dụng VoidCallback cho callback không trả về gì
  final bool? isDisable;
  final double? height;
  final double? width;

  const AppOutlineButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.isDisable,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sử dụng Material để giữ các hiệu ứng Material như sóng nước khi nhấn
    return Material(
      color: Colors.transparent, // Xóa màu nền mặc định của Material
      child: InkWell(
        onTap: isDisable == true ? null : onPress, // Vô hiệu hóa nếu isDisable là true
        borderRadius: BorderRadius.circular(12.w), // Đồng bộ với borderRadius của Container
        child: Opacity(
          opacity: isDisable == true ? 0.4 : 1,
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.White,
              border: Border.all(color: AppColors.PrimaryButton, width: 1),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: AutoSizeText(
                text,
                style: AppTextStyle.outlineButton, // Style mẫu, thay đổi theo nhu cầu
              ),
            ),
          ),
        ),
      ),
    );
  }
}
