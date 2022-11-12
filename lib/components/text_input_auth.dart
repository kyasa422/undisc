
import 'package:flutter/material.dart';

Container textInputAuth({
  required BuildContext context,
  TextEditingController? controller,
  String? hintText,
  String? errorText,
  TextInputType? keyboardType,
  bool last = false,
  bool obscureText = false,
  String? Function(String?)? validator
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: !last ? const Border(
        bottom: BorderSide(color: Colors.grey),
      ) : null,
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    ),
  );
}