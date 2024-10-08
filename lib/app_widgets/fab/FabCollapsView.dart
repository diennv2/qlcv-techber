import 'package:flutter/material.dart';
import 'package:mobile_rhm/core/values/colors.dart';

class FabCollapsView extends StatelessWidget {
  const FabCollapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/compose');
        },
        splashColor: AppColors.Red50,
        backgroundColor: AppColors.Primary,
        icon: const Icon(
          Icons.edit,
          color: Colors.red,
        ),
        label: const Center(
          child: Text(
            "Compose",
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
