import 'package:flutter/material.dart';
import '../themes/themes.dart';

TextFormField textFormField({
  TextEditingController? controller,
  String? Function(String?)? validator,
  String? hintText,
  bool obscureText = false,
  String? errorText,
  TextInputType? keyboardType
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: obscureText,
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