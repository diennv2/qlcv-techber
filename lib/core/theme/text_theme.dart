import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:mobile_rhm/core/values/font_family.dart';

class AppTextStyle {
  AppTextStyle._();

  //Define all text style here
  //Base style
  static const regular = TextStyle(fontFamily: FontFamily.fontRegular, color: AppColors.PrimaryText, fontWeight: FontWeight.w400);
  static const medium = TextStyle(fontFamily: FontFamily.fontMedium, color: AppColors.PrimaryText, fontWeight: FontWeight.w500);
  static const semi_bold = TextStyle(fontFamily: FontFamily.fontSemiBold, color: AppColors.PrimaryText, fontWeight: FontWeight.w600);
  static const bold = TextStyle(fontFamily: FontFamily.fontBold, color: AppColors.PrimaryText, fontWeight: FontWeight.w700);

  //Regular
  static final regular_8 = regular.copyWith(fontSize: 8.sp);
  static final regular_9 = regular.copyWith(fontSize: 9.sp);
  static final regular_10 = regular.copyWith(fontSize: 10.sp);
  static final regular_11 = regular.copyWith(fontSize: 11.sp);
  static final regular_12 = regular.copyWith(fontSize: 12.sp);
  static final regular_13 = regular.copyWith(fontSize: 13.sp);
  static final regular_14 = regular.copyWith(fontSize: 14.sp);
  static final regular_15 = regular.copyWith(fontSize: 15.sp);
  static final regular_16 = regular.copyWith(fontSize: 16.sp);
  static final regular_18 = regular.copyWith(fontSize: 18.sp);
  static final regular_20 = regular.copyWith(fontSize: 20.sp);
  static final regular_24 = regular.copyWith(fontSize: 24.sp);
  static final regular_32 = regular.copyWith(fontSize: 32.sp);

  //Medium
  static final medium_8 = medium.copyWith(fontSize: 8.sp);
  static final medium_9 = medium.copyWith(fontSize: 9.sp);
  static final medium_10 = medium.copyWith(fontSize: 10.sp);
  static final medium_11 = medium.copyWith(fontSize: 11.sp);
  static final medium_12 = medium.copyWith(fontSize: 12.sp);
  static final medium_13 = medium.copyWith(fontSize: 13.sp);
  static final medium_14 = medium.copyWith(fontSize: 14.sp);
  static final medium_15 = medium.copyWith(fontSize: 15.sp);
  static final medium_16 = medium.copyWith(fontSize: 16.sp);
  static final medium_18 = medium.copyWith(fontSize: 18.sp);
  static final medium_20 = medium.copyWith(fontSize: 20.sp);
  static final medium_24 = medium.copyWith(fontSize: 24.sp);
  static final medium_32 = medium.copyWith(fontSize: 32.sp);

  //Semi
  static final semi_bold_8 = semi_bold.copyWith(fontSize: 8.sp);
  static final semi_bold_9 = semi_bold.copyWith(fontSize: 9.sp);
  static final semi_bold_10 = semi_bold.copyWith(fontSize: 10.sp);
  static final semi_bold_11 = semi_bold.copyWith(fontSize: 11.sp);
  static final semi_bold_12 = semi_bold.copyWith(fontSize: 12.sp);
  static final semi_bold_13 = semi_bold.copyWith(fontSize: 13.sp);
  static final semi_bold_14 = semi_bold.copyWith(fontSize: 14.sp);
  static final semi_bold_15 = semi_bold.copyWith(fontSize: 15.sp);
  static final semi_bold_16 = semi_bold.copyWith(fontSize: 16.sp);
  static final semi_bold_18 = semi_bold.copyWith(fontSize: 18.sp);
  static final semi_bold_20 = semi_bold.copyWith(fontSize: 20.sp);
  static final semi_bold_24 = semi_bold.copyWith(fontSize: 24.sp);
  static final semi_bold_32 = semi_bold.copyWith(fontSize: 32.sp);

  //Bold
  static final bold_8 = bold.copyWith(fontSize: 8.sp);
  static final bold_9 = bold.copyWith(fontSize: 9.sp);
  static final bold_10 = bold.copyWith(fontSize: 10.sp);
  static final bold_11 = bold.copyWith(fontSize: 11.sp);
  static final bold_12 = bold.copyWith(fontSize: 12.sp);
  static final bold_13 = bold.copyWith(fontSize: 13.sp);
  static final bold_14 = bold.copyWith(fontSize: 14.sp);
  static final bold_15 = bold.copyWith(fontSize: 15.sp);
  static final bold_16 = bold.copyWith(fontSize: 16.sp);
  static final bold_18 = bold.copyWith(fontSize: 18.sp);
  static final bold_20 = bold.copyWith(fontSize: 20.sp);
  static final bold_24 = bold.copyWith(fontSize: 24.sp);
  static final bold_32 = bold.copyWith(fontSize: 32.sp);

  //Common
  static final H0 = semi_bold_32;
  static final H1 = medium_24;
  static final button = medium_16;
  static final sub_title = semi_bold_18;
  static final body_text = regular_16;
  static final sub_body_regular = regular_14;
  static final sub_body_medium = medium_14;

  //Define all text style here
  static TextStyle _buildStyle(Color color, double fontSize, FontWeight fontWeight, {String? fontFamily}) {
    return TextStyle(fontFamily: fontFamily ?? FontFamily.fontRegular, color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  /**
   * Regular
   * */
  static TextStyle grayRegular15 = _buildStyle(AppColors.TextGray, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle primary13Regular = _buildStyle(AppColors.Primary, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle white15Regular = _buildStyle(AppColors.White, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle white13Regular = _buildStyle(AppColors.White, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle white14Regular = _buildStyle(AppColors.White, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle white17Regular = _buildStyle(AppColors.White, 17.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle gray15Regular = _buildStyle(AppColors.TextGray, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle gray13Regular = _buildStyle(AppColors.TextGray, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle gray11Regular = _buildStyle(AppColors.TextGray, 11.sp, FontWeight.w700, fontFamily: FontFamily.fontRegular);

  static TextStyle lightBlack13Regular = _buildStyle(AppColors.LighBlack, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle lightBlack15Regular = _buildStyle(AppColors.LighBlack, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle coolDark15Regular = _buildStyle(AppColors.CoolDark, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle lightBlack12Regular = _buildStyle(AppColors.LighBlack, 12.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle primaryDark12Regular = _buildStyle(AppColors.PrimaryDark, 12.sp, FontWeight.w600, fontFamily: FontFamily.fontRegular);

  static TextStyle darkGray12Regular = _buildStyle(AppColors.DarkGray, 12.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle darkGray13Regular = _buildStyle(AppColors.DarkGray, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle medium12Regular = _buildStyle(AppColors.Medium, 12.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle medium13Regular = _buildStyle(AppColors.Medium, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle medium15Regular = _buildStyle(AppColors.Medium, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle medium11Regular = _buildStyle(AppColors.Medium, 11.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle primary15Regular = _buildStyle(AppColors.Primary, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary12Regular = _buildStyle(AppColors.Secondary, 12.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary15Regular = _buildStyle(AppColors.Secondary, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary13_2Regular = _buildStyle(AppColors.Secondary2, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary13_3Regular = _buildStyle(AppColors.Secondary3, 13.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary13_3Regular_600 = _buildStyle(AppColors.Secondary3, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary12_3Regular = _buildStyle(AppColors.Secondary3, 12.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary12_2Regular = _buildStyle(AppColors.Secondary2, 12.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary14_Regular = _buildStyle(AppColors.SecondaryText, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary15_4Regular = _buildStyle(AppColors.Secondary4, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary15_2Regular = _buildStyle(AppColors.Secondary2, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary15_3Regular = _buildStyle(AppColors.Secondary3, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary15_Regular = _buildStyle(AppColors.Secondary, 15.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary15_Regular_600 = _buildStyle(AppColors.Secondary, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary17Regular = _buildStyle(AppColors.Secondary, 17.sp, FontWeight.w600, fontFamily: FontFamily.fontRegular);

  static TextStyle secondary28Medium = _buildStyle(AppColors.Secondary, 28.sp, FontWeight.w600, fontFamily: FontFamily.fontMedium);

  /**
   * Medium font
   * */
  static TextStyle coolDark14 = _buildStyle(AppColors.CoolDark, 14.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle coolDark15 = _buildStyle(AppColors.CoolDark, 15.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle coolDark12 = _buildStyle(AppColors.CoolDark, 12.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle coolDark13 = _buildStyle(AppColors.CoolDark, 13.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle red12 = _buildStyle(AppColors.Red, 12.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle red15 = _buildStyle(AppColors.Red, 15.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle gray12 = _buildStyle(AppColors.TextGray, 12.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle gray14 = _buildStyle(AppColors.TextGray, 14.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle primary12 = _buildStyle(AppColors.Primary, 12.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle primary14 = _buildStyle(AppColors.Primary, 14.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  /**
   * Bold font
   * */
  static TextStyle grayBold14 = _buildStyle(AppColors.TextGray, 14.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle grayBold12 = _buildStyle(AppColors.TextGray, 12.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle primaryBold14 = _buildStyle(AppColors.Primary, 14.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle primaryBold12 = _buildStyle(AppColors.Primary, 12.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle whiteBold18 = _buildStyle(AppColors.White, 18.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle whiteBold14 = _buildStyle(AppColors.White, 14.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle coolDarkBold18 = _buildStyle(AppColors.CoolDark, 18.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle coolDarkBold28 = _buildStyle(AppColors.CoolDark, 28.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  static TextStyle coolDarkBold24 = _buildStyle(AppColors.CoolDark, 24.sp, FontWeight.w700, fontFamily: FontFamily.fontBold);

  /**
   * Semi-Bold
   * */
  static TextStyle darkSemi13 = _buildStyle(AppColors.PrimaryDark, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle blackSemi13 = _buildStyle(AppColors.LighBlack, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle whiteSemi20 = _buildStyle(AppColors.White, 20.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle whiteSemi15 = _buildStyle(AppColors.White, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle whiteSemi17 = _buildStyle(AppColors.White, 17.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle coolDartSemi15 = _buildStyle(AppColors.CoolDark, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle coolDartSemi12 = _buildStyle(AppColors.CoolDark, 12.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle coolDartSemi20 = _buildStyle(AppColors.CoolDark, 20.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle mediumSemi15 = _buildStyle(AppColors.Medium, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle redSemi13 = _buildStyle(AppColors.Red, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle redSemi15 = _buildStyle(AppColors.Red, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle redSemi17 = _buildStyle(AppColors.Red, 17.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle graySemi13 = _buildStyle(AppColors.TextGray, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle graySemi15 = _buildStyle(AppColors.TextGray, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle grayLightSemi15 = _buildStyle(AppColors.Gray, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle primarySemi15 = _buildStyle(AppColors.Primary, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle primarySemi17 = _buildStyle(AppColors.Primary, 17.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle primarySemi20 = _buildStyle(AppColors.Primary, 20.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle primarySemi15_1 = _buildStyle(AppColors.Primary_1, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle primaryDark12Semi = _buildStyle(AppColors.PrimaryDark, 12.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle coolDartSemi17 = _buildStyle(AppColors.CoolDark, 17.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi313 = _buildStyle(AppColors.Secondary3, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi15 = _buildStyle(AppColors.Secondary, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi15_2 = _buildStyle(AppColors.Secondary2, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi15_3 = _buildStyle(AppColors.Secondary3, 15.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi13 = _buildStyle(AppColors.Secondary, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle whiteSemi13 = _buildStyle(AppColors.White, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi13_4 = _buildStyle(AppColors.Secondary4, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi13_2 = _buildStyle(AppColors.Secondary2, 13.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle secondarySemi17 = _buildStyle(AppColors.Secondary, 17.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);

  static TextStyle primaryButton = _buildStyle(AppColors.White, 16.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle primaryButtonSmall = _buildStyle(AppColors.White, 14.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle secondaryButton = _buildStyle(AppColors.PrimaryText, 16.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle secondaryButtonSmall = _buildStyle(AppColors.PrimaryText, 14.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle outlineButton = _buildStyle(AppColors.BrandText, 14.sp, FontWeight.w500, fontFamily: FontFamily.fontMedium);

  static TextStyle textButton = _buildStyle(AppColors.SecondaryText, 16.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle errorToast = _buildStyle(AppColors.ErrorText, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle successToast = _buildStyle(AppColors.SuccessText, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle secondaryText = _buildStyle(AppColors.SecondaryText, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle primaryText = _buildStyle(AppColors.PrimaryText, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle placeHolderText = _buildStyle(AppColors.PlaceHolderText, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle errorLabel = _buildStyle(AppColors.ErrorText, 14.sp, FontWeight.w400, fontFamily: FontFamily.fontRegular);

  static TextStyle title = _buildStyle(AppColors.PrimaryText, 18.sp, FontWeight.w600, fontFamily: FontFamily.fontSemiBold);
}
