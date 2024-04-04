import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/widgets/custom_checkbox.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';

class DemoTab extends StatelessWidget {
  const DemoTab({
    super.key,
    required this.state,
  });

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController age = TextEditingController();

    return OnboardingScreenLayout(
      currentStep: 3,
      onPressed: () {
        context
            .read<OnboardingBloc>()
            .add(ContinueOnboarding(user: state.user));

        context.read<OnboardingBloc>().add(UpdateUser(
                user: state.user.copyWith(
              name: name.text,
              age: int.parse(age.text),
            )));
      },
      children: [
        const CustomTextHeader(
          text: "What's Your Name?",
        ),
        CustomTextField(
          hint: "ENTER YOUR NAME",
          controller: name,
        ),
        const SizedBox(height: 50.0),
        const CustomTextHeader(
          text: "What's Your Gender?",
        ),
        const SizedBox(height: 10.0),
        CustomCheckbox(
          text: "MALE",
          value: state.user.gender == "Male",
          onChanged: (val) {
            context.read<OnboardingBloc>().add(
                  UpdateUser(user: state.user.copyWith(gender: "Male")),
                );
          },
        ),
        CustomCheckbox(
          text: "FEMALE",
          value: state.user.gender == "Female",
          onChanged: (val) {
            context.read<OnboardingBloc>().add(
                  UpdateUser(user: state.user.copyWith(gender: "Female")),
                );
          },
        ),
        const SizedBox(height: 100.0),
        const CustomTextHeader(
          text: "What's Your Age?",
        ),
        CustomTextField(
          hint: "ENTER YOUR AGE",
          controller: age,
        ),
      ],
    );
  }
}
