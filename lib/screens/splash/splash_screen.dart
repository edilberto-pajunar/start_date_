import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/screens/home/home_screen.dart';
import 'package:start_date/screens/login/login_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/screens/settings/settings_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.authUser != current.authUser,
        listener: (context, state) {
          print("Listener");
          print(state.status);
          if (state.status == AuthStatus.unauthenticated) {
            Timer(const Duration(seconds: 1), () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            });
          } else if (state.status == AuthStatus.authenticated) {
            Timer(const Duration(seconds: 3), () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsScreen()));
            });
          }
        },
        child: Scaffold(
          body: Container(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/start.png",
                  ),
                  const Text(
                    "Start Date",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
