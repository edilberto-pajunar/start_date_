import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/repositories/auth/auth_repository.dart';
import 'package:start_date/screens/home/home_screen.dart';
import 'package:start_date/screens/home/invitation_screen.dart';
import 'package:start_date/screens/login/login_screen.dart';
import 'package:start_date/widgets/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) {
          if (previous.authUser == null && current.authUser == null) {
            return previous.authUser == current.authUser;
          } else {
            return previous.authUser != current.authUser;
          }
        },
        listener: (context, state) {
          print("Listener");
          print(state.status);
          if (state.status == AuthStatus.unauthenticated) {
            Timer(const Duration(seconds: 1), () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            });
          } else if (state.status == AuthStatus.authenticated) {
            Timer(const Duration(seconds: 3), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                if (!state.user!.partner!.isTaken) {
                  return const InvitationScreen();
                } else {
                  return const HomeScreen();
                }
              }));
            });
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/start.png",
                ),
                const Text(
                  "Start Date",
                ),
                CustomButton(
                  text: "Sign out",
                  onPressed: () {
                    context.read<AuthRepository>().signOut();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
