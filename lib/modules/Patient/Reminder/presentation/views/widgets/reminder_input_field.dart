import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants.dart';

import 'reminder_themes.dart';

class ReminderInputField extends StatelessWidget {
  final TextEditingController textValueController;
  final String? valueKey;
  final String label;
  final Function? onValidate;
  final Function? onEditComplete;
  final String hint;
  final int? maxLine;
  final FocusNode node;
  final TextInputType? textInputType;
  final String? initialValue;
  final Widget? suffixIcon;
  final Function? onSuffixTap;
  final double scale;
  const ReminderInputField({
    Key? key,
    required this.textValueController,
    this.maxLine,
    this.textInputType,
    this.onSuffixTap,
    this.initialValue,
    this.suffixIcon,
    this.onEditComplete,
    this.onValidate,
    this.valueKey,
    required this.hint,
    required this.label,
    required this.node,
    required this.scale,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0 * scale),
          child: Text(
            label,
            style: ReminderThemes().labelStyle.copyWith(
                fontSize: ReminderThemes().labelStyle.fontSize! * scale),
          ),
        ),
        TextFormField(
          style: TextStyle(fontSize: 16 * scale),
          maxLines: maxLine,
          readOnly: onSuffixTap == null ? false : true,
          controller: textValueController,
          initialValue: initialValue,
          cursorColor: MyColors.myGrey,
          focusNode: node,
          key: ValueKey(valueKey),
          validator: onValidate as String? Function(String?)?,
          textInputAction: TextInputAction.next,
          onEditingComplete: onEditComplete as void Function()?,
          keyboardType: textInputType,
          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 16.0 * scale),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColors.myBlue,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.myBlue, width: 2.0),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            filled: true,
            suffixIcon: InkWell(
              onTap: onSuffixTap as void Function()?,
              child: suffixIcon!,
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 16 * scale),
            labelStyle: TextStyle(fontSize: 16 * scale),
          ),
        ),
      ],
    );
  }
}
