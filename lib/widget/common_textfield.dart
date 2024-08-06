import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final AutovalidateMode? autoValidateMode;
  final void Function(String)? onChanged;

  const CommonTextField({
    super.key,
    required this.textEditingController,
    required  this.focusNode,
    this.maxLines,
    this.hintText,
    this.hintTextStyle,
    this.labelText,
    this.labelTextStyle,
    this.autoValidateMode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.zero,
      controller: textEditingController,
      focusNode: focusNode,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value == "") {
          return "This field is mandatory";
        }
        return null;
      },
      // maxLength: maxLength,
      maxLines: maxLines ?? 1,
      minLines: 1,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        isDense: true,
        label: Text(
          labelText ?? "",
          style: labelTextStyle ?? const TextStyle(),
        ),
        hintText: hintText,
        hintStyle: hintTextStyle ?? const TextStyle(),
        counter: const SizedBox.shrink(),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
