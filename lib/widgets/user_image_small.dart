import 'package:flutter/material.dart';

class UserImageSmall extends StatelessWidget {
  const UserImageSmall({
    super.key,
    required this.imageUrl,
    this.height = 60,
    this.width = 60,
  });

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 8,
        right: 8,
      ),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
