import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/swipe/swipe_bloc.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/screens/home/home_screen.dart';
import 'package:start_date/screens/matches/matches_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/screens/users/users_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwipeBloc()..add(LoadUsersEvent(users: User.users)),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MatchesScreen(),
      ),
    );
  }
}
