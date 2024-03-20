import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/widgets/choice_button.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.5,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Hero(
                    tag: "user_image ",
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            user.imageUrls[0],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceButton(
                          width: 60,
                          height: 60,
                          color: theme.colorScheme.primary,
                          size: 25,
                          icon: Icons.clear_rounded,
                          onTap: () {},
                        ),
                        ChoiceButton(
                          width: 80,
                          height: 80,
                          color: theme.colorScheme.secondary,
                          size: 30,
                          icon: Icons.favorite,
                          onTap: () {},
                        ),
                        ChoiceButton(
                          width: 60,
                          height: 60,
                          color: theme.colorScheme.primary,
                          size: 25,
                          icon: Icons.watch_later,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name}, ${user.age}",
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.jobTitle,
                  style: theme.textTheme.titleSmall!.copyWith(),
                ),
                const SizedBox(height: 15.0),
                Text(
                  "About",
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.bio,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    height: 2.0,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  "Interests",
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: user.interests.map((interest) {
                    return Container(
                      margin: const EdgeInsets.only(top: 5.0, right: 5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        user.interests[0],
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
