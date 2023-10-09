import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    Key? key,
    this.prefixIconButton,
    this.suffixIconButton,
    required this.hintText,
    this.onSubmitted,
    this.onTap,
    this.autofocus = true,
    this.controller,
    this.readonly = true,
  }) : super(key: key);

  final IconButton? prefixIconButton;
  final IconButton? suffixIconButton;
  final String hintText;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final bool autofocus;
  final TextEditingController? controller;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      readOnly: readonly,
      autofocus: autofocus,
      onTap: onTap,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xffa09fa0)),
        filled: true,
        fillColor: const Color(0xffedeeee),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        prefixIcon: prefixIconButton,
        suffixIcon: suffixIconButton,
      ),
    );
  }
}
