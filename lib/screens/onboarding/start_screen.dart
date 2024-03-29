import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/widgets/custom_button.dart';

class StartTab extends StatelessWidget {
  const StartTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("assets/images/start.png"),
                    ),
                    const SizedBox(height: 50.0),
                    Text(
                      "Welcome to Start Date",
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Lorem ipsum",
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                CustomButton(
                  text: "Start",
                  onPressed: () {
                    context
                        .read<OnboardingBloc>()
                        .add(ContinueOnboarding(user: state.user));
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Something went wrong."),
          );
        }
      },
    );
  }
}
