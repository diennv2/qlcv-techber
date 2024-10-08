import 'package:flutter/material.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class BorderView extends StatelessWidget {
  final Color? color;
  final double? height;

  const BorderView({Key? key, this.color, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != null ? height! : 1,
      color: color ?? AppColors.Border,
    );
  }
}
