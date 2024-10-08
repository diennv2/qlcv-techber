import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/app_widgets/image_display.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/device_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class MediaSelectButton extends StatelessWidget {
  final String buttonText;
  final PlatformFile? file;
  final Function onSelectMedia;
  final Function clearMedia;

  const MediaSelectButton({Key? key, required this.buttonText, this.file, required this.onSelectMedia, required this.clearMedia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (file == null) {
      var textS = DeviceUtils.textSize(buttonText, AppTextStyle.outlineButton);
      var width = textS.width + 68.w;

      return Material(
        color: Colors.transparent, // Xóa màu nền mặc định của Material
        child: InkWell(
          onTap: () {
            onSelectMedia.call();
          }, // Vô hiệu hóa nếu isDisable là true
          borderRadius: BorderRadius.circular(12.w), // Đồng bộ với borderRadius của Container
          child: Opacity(
            opacity: 1,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppColors.PrimaryButton, width: 1),
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Container(
                width: width,
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    ImageDisplay(
                      Assets.ic_upload_simple,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      buttonText,
                      style: AppTextStyle.outlineButton, // Style mẫu, thay đổi theo nhu cầu
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      height: 48.h,
      padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.White,
        border: Border.all(color: AppColors.PrimaryButton, width: 1),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Row(
        children: [
          ImageDisplay(
            Assets.ic_media_image,
            width: 20.w,
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Text(
                  file?.name ?? '',
                  maxLines: 1,
                  style: AppTextStyle.regular_14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${DeviceUtils.convertBytesToMegabytes(file?.size ?? 0).toStringAsPrecision(1)} MB',
                style: AppTextStyle.regular_14,
              )
            ],
          )),
          SizedBox(
            width: 16.w,
          ),
          TouchableOpacity(
            onTap: () {
              clearMedia.call(file);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: ImageDisplay(
                Assets.ic_icon_x,
                width: 24.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
