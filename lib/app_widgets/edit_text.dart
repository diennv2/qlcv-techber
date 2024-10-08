import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/extentions/string.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class EditTextView extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? isHidePassword;
  final bool? isDisable;
  final TextInputType? inputType;
  final Function? onChangeHidePass;
  final TextInputFormatter? inputFormatter;
  final bool? isShowLabel;
  final String? label;
  final bool? required;
  final Function? onClick;
  final int? maxLength;
  final Function? onChangeValue;
  final bool? isInvalid;
  final String? errorMessage;
  final double? height;
  final int? maxLines;
  final bool? isForceMaxlines;
  final TextAlignVertical? textAlignVertical;

  const EditTextView(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.inputType = TextInputType.text,
      this.isPassword = false,
      this.isHidePassword = true,
      this.isDisable = false,
      this.onChangeHidePass,
      this.inputFormatter,
      this.isShowLabel,
      this.label,
      this.required,
      this.onClick,
      this.maxLength,
      this.height,
      this.maxLines,
      this.isForceMaxlines,
      this.textAlignVertical,
      this.isInvalid,
      this.errorMessage,
      this.onChangeValue})
      : super(key: key);

  @override
  State<EditTextView> createState() => _EditTextViewState();
}

class _EditTextViewState extends State<EditTextView> {
  late FocusNode _focusNode;
  Color _fillColor = AppColors.White; // Mặc định màu nền

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fillColor = widget.isDisable == true ? AppColors.BgInputDisable : AppColors.White;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _fillColor = AppColors.BgInputFocus; // Màu khi có focus
      });
    } else {
      setState(() {
        _fillColor = widget.isDisable == true ? AppColors.BgInputDisable : AppColors.White; // Trở lại màu mặc định khi không có focus
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Đừng quên dispose focusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isInValid = widget.errorMessage.isNotNullOrBlank;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isShowLabel != null && widget.isShowLabel!
            ? Container(
                margin: EdgeInsets.only(bottom: 8.h),
                child: widget.required == true
                    ? RichText(
                        text: TextSpan(style: AppTextStyle.medium_14, children: [
                        TextSpan(text: widget.label ?? widget.hintText),
                        TextSpan(text: ' *', style: AppTextStyle.medium_14.copyWith(color: AppColors.ErrorText)),
                      ]))
                    : Text(
                        widget.label ?? widget.hintText,
                        style: AppTextStyle.medium_14,
                      ),
              )
            : Container(),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: widget.height ?? 48.h,
                child: TextFormField(
                  focusNode: _focusNode,
                  onTap: () {
                    if (widget.onClick != null) {
                      widget.onClick!();
                    }
                  },
                  enabled: widget.isDisable == true ? false : true,
                  maxLength: widget.maxLength ?? TextField.noMaxLength,
                  maxLines: widget.isForceMaxlines == true ? widget.maxLines : widget.maxLines ?? 1,
                  inputFormatters: widget.inputFormatter != null ? [widget.inputFormatter!] : [],
                  readOnly: widget.onClick != null || widget.isDisable!,
                  controller: widget.controller,
                  keyboardType: widget.inputType,
                  obscureText: widget.isPassword! && widget.isHidePassword!,
                  textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 2, left: 16.w, right: 16.w, top: 4),
                      counterText: '',
                      hintText: widget.hintText,
                      hintStyle: AppTextStyle.placeHolderText,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: (isInValid == true ? AppColors.BorderError : AppColors.BgInputDisable)), // Normal state
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: isInValid == true ? AppColors.BorderError : AppColors.BorderFocus), // Focus state
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.BgInputDisable), // Normal state
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.BorderError), // Normal state
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.BorderError), // Focused Error state
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: _fillColor,
                      // Default background color
                      filled: true,
                      suffixIcon: widget.isPassword!
                          ? TouchableOpacity(
                              child: IconButton(
                              onPressed: () {
                                widget.onChangeHidePass!();
                              },
                              icon: Image.asset(
                                widget.isHidePassword! ? Assets.ic_eye_off : Assets.ic_eye_on,
                                width: 18.w,
                                height: 18.w,
                              ),
                            ))
                          : Container(
                              width: 1,
                            )),
                  onChanged: (newValue) {
                    if (widget.onChangeValue != null) {
                      widget.onChangeValue!(newValue);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        (widget.errorMessage.isNotNullOrBlank)
            ? Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.errorMessage!,
                    style: AppTextStyle.errorLabel,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
