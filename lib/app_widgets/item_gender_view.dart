import 'package:flutter/material.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class ItemGenderView extends StatelessWidget {
  final String name;

  const ItemGenderView({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.White, border: Border(bottom: BorderSide(color: AppColors.BorderPrimary, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: AppTextStyle.medium_16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
