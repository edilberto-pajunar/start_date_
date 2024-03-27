import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    this.controller,
    this.onChanged,
    this.onFocusChanged,
  });

  final String text;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChanged;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChanged ?? (hasFocus) {},
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: text,
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
    );
  }
}
