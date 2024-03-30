import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/cubits/signup/signup_cubit.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';

class EmailTab extends StatelessWidget {
  const EmailTab({
    super.key,
    required this.state,
  });

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
      currentStep: 2,
      onPressed: () async {
        await context.read<SignupCubit>().signupWithCredentials().then((value) {
          context.read<OnboardingBloc>().add(
                ContinueOnboarding(
                  isSignup: true,
                  user: User.empty.copyWith(
                    id: context.read<SignupCubit>().state.user!.uid,
                  ),
                ),
              );
        });
      },
      children: [
        const CustomTextHeader(
          text: "What's Your Email Address",
        ),
        CustomTextField(
          hint: "ENTER YOUR EMAIL",
          onChanged: (val) {
            context.read<SignupCubit>().emailChanged(val);
          },
        ),
        const SizedBox(height: 100),
        const CustomTextHeader(
          text: "Choose a Password",
        ),
        CustomTextField(
          hint: "ENTER YOUR PASSWORD",
          onChanged: (val) {
            context.read<SignupCubit>().passwordChanged(val);
          },
        ),
      ],
    );
  }
}
