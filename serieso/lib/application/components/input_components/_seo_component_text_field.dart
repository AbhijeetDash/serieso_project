import 'package:flutter/material.dart';

class SeoTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int? maxLines, maxLength;
  final bool? isObscured;
  final TextInputType? textInputType;
  final FocusNode? currentFocus, nextFocus;

  SeoTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.textInputType,
    this.currentFocus,
    this.nextFocus,
    this.maxLines = 1,
    this.maxLength,
    this.isObscured = false,
  }) : assert(!isObscured! || maxLines == 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white60),
          borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: textInputType,
          focusNode: currentFocus,
          maxLength: maxLength,
          maxLines: maxLines,
          controller: controller,
          obscureText: isObscured!,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          validator: validator,
          onEditingComplete: () {
            nextFocus?.requestFocus();
          },
        ),
      ),
    );
  }
}
