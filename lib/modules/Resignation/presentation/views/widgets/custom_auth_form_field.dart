import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomAuthFormField extends StatelessWidget {
  const CustomAuthFormField({
    Key? key,
    required this.textInputType,
    required this.text,
    required this.prefixIcon,
    required this.controller,
    this.suffixIcon,
    required this.validator,
    this.suffixFunction,
    required this.isMobile,
    required this.width,
    this.isPassword = false,
  }) : super(key: key);

  final TextInputType textInputType;
  final String text;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? suffixIcon;
  final String? Function(String?) validator;
  final void Function()? suffixFunction;
  final bool isMobile;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ? true : false,
      controller: controller,
      keyboardType: textInputType,
      onFieldSubmitted: (value) {
        if (kDebugMode) {}
      },
      onChanged: (value) {
        if (kDebugMode) {}
      },
      validator: validator,
      style: TextStyle(fontSize: isMobile ? null : width * 0.03),
      decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(prefixIcon, size: isMobile ? null : width * 0.04),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon, size: isMobile ? null : width * 0.04),
                  onPressed: suffixFunction,
                )
              : null,
          border: const OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: width * 0.02)),
    );
  }
}
