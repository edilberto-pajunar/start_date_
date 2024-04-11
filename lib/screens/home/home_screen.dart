import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/blocs/profile/profile_bloc.dart';
import 'package:start_date/blocs/swipe/swipe_bloc.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/database/database_repository.dart';
import 'package:start_date/screens/users/users_screen.dart';
import 'package:start_date/widgets/choice_button.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/custom_elevated_button.dart';
import 'package:start_date/widgets/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) => SwipeBloc(
        authBloc: context.read<AuthBloc>(),
        databaseRepository: context.read<DatabaseRepository>(),
      )..add(LoadUsers()),
      child: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Scaffold(
              appBar: CustomAppbar(
                title: "Start Date",
                hasActions: true,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is SwipeLoaded) {
            return SwipeLoadedHomeScreen(state: state);
          }
          if (state is SwipeMatched) {
            return SwipeMatchedHomeScreen(state: state);
          }
          if (state is SwipeError) {
            return const Scaffold(
              appBar: CustomAppbar(
                title: "Start Date",
                hasActions: true,
              ),
              body: Center(
                child: Text("There aren't any more users."),
              ),
            );
          } else {
            return const Text("Something went wrong.");
          }
        },
      ),
    );
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({
    super.key,
    required this.state,
  });

  final SwipeLoaded state;

  @override
  Widget build(BuildContext context) {
    final user = state.users[0];

    final User partner = state.users
        .where((partner) => partner.id == user.partner!.partnerId)
        .toList()
        .first;

    final bool partnerSwipedRight =
        state.partner!.swipeRight!.contains(user.id);

    print(partnerSwipedRight);

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Start Date",
        hasActions: true,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UsersScreen(
                        user: state.users[0],
                      )));
            },
            child: Column(
              children: [
                Draggable(
                  feedback: Column(
                    children: [
                      UserCard(
                        user: state.users[0],
                        heroTag: "partner1",
                        partner: state.partner!,
                      ),
                      UserCard(
                        user: partner,
                        heroTag: "partner2",
                        partner: state.partner!,
                      ),
                    ],
                  ),
                  // childWhenDragging: (userCount > 1)
                  //     ? Column(
                  //         children: [
                  //           UserCard(
                  //             user: state.users[1],
                  //             heroTag: "partner1",
                  //           ),
                  //           UserCard(
                  //             user: partner,
                  //             heroTag: "partner2",
                  //           ),
                  //         ],
                  //       )
                  //     : Container(),
                  childWhenDragging: Column(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.withOpacity(0.5),
                              Colors.black.withOpacity(0.1),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.withOpacity(0.5),
                              Colors.black.withOpacity(0.1),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      UserCard(
                        user: state.users[0],
                        heroTag: "partner1",
                        partner: state.partner!,
                      ),
                      UserCard(
                        user: partner,
                        heroTag: "partner2",
                        partner: state.partner!,
                      ),
                    ],
                  ),
                  onDragEnd: (drag) {
                    if (drag.offset.dx < -100) {
                      context.read<SwipeBloc>().add(SwipeLeft(
                            currentUser: context.read<AuthBloc>().state.user!,
                            user: state.users[0],
                            userPartner: partner,
                          ));
                      print("Swiped Left");
                    } else if (drag.offset.dx > 100) {
                      context.read<SwipeBloc>().add(SwipeRight(
                            currentUser: context.read<AuthBloc>().state.user!,
                            user: state.users[0],
                            userPartner: partner,
                          ));
                      print("Swiped right");
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 60.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceButton(
                  color: theme.colorScheme.primary,
                  icon: Icons.clear_rounded,
                  onTap: () {
                    // context.read<SwipeBloc>().add(SwipeLeft(
                    //       currentUser: context.read<AuthBloc>().state.user!,
                    //       user: state.users[0],
                    //       partner: partner[0],
                    //     ));
                  },
                ),
                ChoiceButton(
                  width: 80,
                  height: 80,
                  color: theme.colorScheme.secondary,
                  size: 30,
                  icon: Icons.favorite,
                  onTap: () {
                    // context.read<SwipeBloc>().add(
                    //       SwipeRight(
                    //         currentUser: context.read<AuthBloc>().state.user!,
                    //         user: state.users[0],
                    //         partner: partner[0],
                    //       ),
                    //     );
                  },
                ),
                ChoiceButton(
                  color: theme.colorScheme.primary,
                  icon: Icons.watch_later,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    super.key,
    required this.state,
  });

  final SwipeMatched state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Congrats, it's a match!",
              style: theme.textTheme.bodyLarge!.copyWith(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              "You and ${state.user.name} have liked each other!",
              style: theme.textTheme.headlineLarge!.copyWith(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: CircleAvatar(
                      radius: 45.0,
                      backgroundImage: NetworkImage(
                        context.read<AuthBloc>().state.user!.imageUrls[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: CircleAvatar(
                      radius: 45.0,
                      backgroundImage: NetworkImage(
                        state.user.imageUrls[0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const CustomElevatedButton(
              text: "SEND A MESSAGE",
              color: Colors.white,
              textColor: Colors.black,
            ),
            const SizedBox(height: 10.0),
            CustomElevatedButton(
              text: "BACK TO SWIPING",
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                context.read<SwipeBloc>().add(LoadUsers());
              },
            ),
          ],
        ),
      ),
    );
  }
}
