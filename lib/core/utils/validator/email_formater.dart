import 'package:flutter/services.dart';

class EmailTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9_\-.@]+$');

    if (validCharacters.hasMatch(newValue.text) || newValue.text.isEmpty) {
      return newValue; // Chấp nhận giá trị mới nếu nó hợp lệ
    } else {
      return oldValue; // Giữ giá trị cũ nếu giá trị mới không hợp lệ
    }
  }
}
