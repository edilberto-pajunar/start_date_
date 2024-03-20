import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    this.width = 60,
    this.height = 60,
    this.size = 25,
    required this.color,
    required this.icon,
    this.onTap,
  });

  final double? width;
  final double? height;
  final double? size;
  final Color color;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 4.0,
            blurRadius: 4.0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
