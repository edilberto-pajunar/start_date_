import 'package:flutter/material.dart';

class CustomTextContainer extends StatelessWidget {
  const CustomTextContainer({
    super.key,
    required this.tabController,
    required this.text,
  });

  final TabController tabController;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0 ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.black,
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
