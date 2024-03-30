import 'package:flutter/material.dart';

class AddUserImage extends StatelessWidget {
  const AddUserImage({
    required this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: const Border(
            bottom: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
