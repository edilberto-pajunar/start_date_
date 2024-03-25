import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/swipe/swipe_bloc.dart';
import 'package:start_date/screens/users/users_screen.dart';
import 'package:start_date/widgets/choice_button.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/user_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: "Start Date",
        hasActions: true,
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            var userCount = state.users.length;

            return Column(
              children: [
                InkWell(
                  onDoubleTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UsersScreen(
                              user: state.users[0],
                            )));
                  },
                  child: Draggable(
                    feedback: UserCard(user: state.users[0]),
                    childWhenDragging: (userCount > 1)
                        ? UserCard(user: state.users[1])
                        : Container(),
                    child: UserCard(user: state.users[0]),
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < -100) {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeLeft(user: state.users[0]));
                        print("Swiped Left");
                      } else if (drag.offset.dx > 100) {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeRight(user: state.users[0]));
                        print("Swiped right");
                      }
                    },
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
                          context
                              .read<SwipeBloc>()
                              .add(SwipeLeft(user: state.users[0]));
                        },
                      ),
                      ChoiceButton(
                        width: 80,
                        height: 80,
                        color: theme.colorScheme.secondary,
                        size: 30,
                        icon: Icons.favorite,
                        onTap: () {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeLeft(user: state.users[0]));
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
            );
          }
          if (state is SwipeError) {
            return const Center(
              child: Text("There aren't any more users."),
            );
          } else {
            return const Text("Something went wrong.");
          }
        },
      ),
    );
  }
}
