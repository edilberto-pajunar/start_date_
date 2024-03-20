import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.hasActions = false,
  });

  final String title;
  final bool hasActions;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            const Expanded(
              child: Icon(
                Icons.logo_dev,
                size: 40,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: hasActions
            ? [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
                const SizedBox(width: 10.0),
              ]
            : null,
      ),
    );
  }
}
