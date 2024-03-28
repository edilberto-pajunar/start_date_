import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint = "",
    this.initialValue = "",
    this.controller,
    this.onChanged,
    this.onFocusChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChanged;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Focus(
        onFocusChange: onFocusChanged ?? (hasFocus) {},
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            contentPadding: const EdgeInsets.only(bottom: 5.0, top: 12.5),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
