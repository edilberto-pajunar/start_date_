import 'package:flutter/material.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/screens/chat/chat_screen.dart';
import 'package:start_date/screens/profile/profile_screen.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.hasActions = false,
    this.automaticallyImplyLeading = false,
  });

  final String title;
  final bool hasActions;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChatScreen()));
                  },
                  icon: const Icon(Icons.message),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
                  },
                  icon: const Icon(Icons.settings),
                ),
                const SizedBox(width: 10.0),
              ]
            : null,
      ),
    );
  }
}
