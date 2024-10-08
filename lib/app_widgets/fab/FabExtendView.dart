import 'package:flutter/material.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class FabExtendView extends StatelessWidget {
  const FabExtendView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {
          //Todo add later
        },
        splashColor: AppColors.CoolDark,
        backgroundColor: AppColors.Primary,
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(Icons.edit, color: Colors.red),
        ),
        label: const SizedBox(),
      ),
    );
  }
}
