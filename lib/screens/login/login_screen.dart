import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/cubits/login/login_cubit.dart';
import 'package:start_date/screens/home/home_screen.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/custom_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "START DATE",
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EmailInput(),
              const SizedBox(height: 10.0),
              const PasswordInput(),
              const SizedBox(height: 10.0),
              CustomElevatedButton(
                text: "LOGIN",
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  context.read<LoginCubit>().loginWithCredentials();
                },
              ),
              const SizedBox(height: 10.0),
              CustomElevatedButton(
                text: "SIGN UP",
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OnboardingScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(
            label: Text("Email"),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(
            label: Text("Password"),
          ),
          obscureText: true,
        );
      },
    );
  }
}
