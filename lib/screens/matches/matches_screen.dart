import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/match/match_bloc.dart';
import 'package:start_date/models/match_model.dart';
import 'package:start_date/screens/chat/chat_screen.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/custom_elevated_button.dart';
import 'package:start_date/widgets/user_image_small.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: "MATCHES",
      ),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MatchLoaded) {
            final inactiveMatches =
                state.matches.where((match) => match.chat == null).toList();

            final activeMatches =
                state.matches.where((match) => match.chat != null).toList();

            return SingleChildScrollView(
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
                    MatchesList(inactiveMatches: inactiveMatches),
                    const SizedBox(height: 10),
                    Text(
                      "Your Chats",
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ChatsList(activeMatches: activeMatches, theme: theme),
                  ],
                ),
              ),
            );
          }
          if (state is MatchUnavailable) {
            return Column(
              children: [
                Text(
                  "No matches yet",
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 20.0),
                CustomElevatedButton(
                  text: "BACK TO SWIPING",
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Something went wrong."),
            );
          }
        },
      ),
    );
  }
}

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
    required this.activeMatches,
    required this.theme,
  });

  final List<Match> activeMatches;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => ChatScreen(
            //           userMatch: activeMatches[index],
            //         )));
          },
          child: Row(
            children: [
              UserImageSmall(
                imageUrl: activeMatches[index].matchUser.imageUrls[0],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeMatches[index].matchUser.name,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    activeMatches[index].chat!.messages[0].message,
                  ),
                  Text(
                    activeMatches[index].chat!.messages[0].timeString,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class MatchesList extends StatelessWidget {
  const MatchesList({
    super.key,
    required this.inactiveMatches,
  });

  final List<Match> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                imageUrl: inactiveMatches[index].matchUser.imageUrls[0],
              ),
              Text(
                inactiveMatches[index].matchUser.name,
              ),
            ],
          );
        },
      ),
    );
  }
}
