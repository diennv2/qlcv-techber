import 'package:flutter/material.dart';

class ModalContentBase extends StatelessWidget {
  final Widget child;

  const ModalContentBase({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 16,
      child: child,
    );
  }
}
