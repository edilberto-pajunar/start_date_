import 'package:flutter/material.dart';
import 'package:start_date/models/user_match_model.dart';
import 'package:start_date/screens/chat/chat_screen.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/user_image_small.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();

    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: const CustomAppbar(
        title: "MATCHES",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Likes",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: inactiveMatches.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        UserImageSmall(
                          height: 70,
                          width: 70,
                          imageUrl:
                              inactiveMatches[index].matchedUser.imageUrls[0],
                        ),
                        Text(
                          inactiveMatches[index].matchedUser.name,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Your Chats",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                userMatch: activeMatches[index],
                              )));
                    },
                    child: Row(
                      children: [
                        UserImageSmall(
                          imageUrl:
                              activeMatches[index].matchedUser.imageUrls[0],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activeMatches[index].matchedUser.name,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              activeMatches[index].chat![0].messages[0].message,
                            ),
                            Text(
                              activeMatches[index]
                                  .chat![0]
                                  .messages[0]
                                  .timeString,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
