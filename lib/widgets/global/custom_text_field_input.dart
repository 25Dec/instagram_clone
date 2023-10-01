import 'package:flutter/material.dart';

class CustomTextFieldInput extends StatelessWidget {
  const CustomTextFieldInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.isSecure = false,
    required this.textInputType,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isSecure;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isSecure,
    );
  }
}
