import 'package:flutter/material.dart';
import '../themes/themes.dart';

TextFormField textFormField({
  TextEditingController? controller,
  String? Function(String?)? validator,
  String? hintText,
  bool obscureText = false,
  String? errorText,
  TextInputType? keyboardType,
  int? minLines,
  int? maxLines,
  TextInputAction? textInputAction
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    minLines: minLines,
    maxLines: maxLines,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: obscureText,
    textInputAction: textInputAction,
    decoration: InputDecoration(
      filled: true,
      fillColor: Themes().grey300,
      errorText: errorText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide.none
      )
    ),
  );
}