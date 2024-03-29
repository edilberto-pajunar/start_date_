import 'package:flutter/material.dart';

class CustomTextHeader extends StatelessWidget {
  const CustomTextHeader({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.headlineLarge,
    );
  }
}
