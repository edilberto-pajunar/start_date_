import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.text,
    required this.color,
    required this.textColor,
    this.onPressed,
    this.width = 200,
    super.key,
  });

  final String text;
  final Color color;
  final Color textColor;
  final Function()? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: Size(width, 50),
          shape: const RoundedRectangleBorder(),
          backgroundColor: color,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
