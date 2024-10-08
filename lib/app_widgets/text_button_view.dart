import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class TextButtonView extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Function onClick;
  final bool? isDisable;

  const TextButtonView({Key? key, required this.text, this.textStyle, required this.onClick, this.isDisable = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
        onTap: () {
          if (!isDisable!) onClick();
        },
        child: SizedBox(
          height: 32.h,
          child: Text(
            text,
            style: textStyle ?? AppTextStyle.textButton,
          ),
        ));
  }
}
