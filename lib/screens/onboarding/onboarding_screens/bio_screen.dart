import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/widgets/custom_text_container.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';

class BioTab extends StatelessWidget {
  const BioTab({
    super.key,
    required this.state,
  });

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    final TextEditingController bio = TextEditingController();
    final TextEditingController jobTitle = TextEditingController();

    return OnboardingScreenLayout(
      currentStep: 5,
      onPressed: () {
        context
            .read<OnboardingBloc>()
            .add(ContinueOnboarding(user: state.user));

        context.read<OnboardingBloc>().add(UpdateUser(
                user: state.user.copyWith(
              bio: bio.text,
              jobTitle: jobTitle.text,
            )));
      },
      children: [
        const CustomTextHeader(
          text: "Describe Yourself a Bit",
        ),
        CustomTextField(
          hint: "ENTER YOUR BIO",
          controller: bio,
        ),
        const CustomTextHeader(
          text: "What do you do?",
        ),
        CustomTextField(
          hint: "ENTER YOUR JOB TITLE",
          controller: jobTitle,
        ),
        const SizedBox(height: 50.0),
        const CustomTextHeader(
          text: "What Do You Like?",
        ),
        const SizedBox(height: 10.0),
        const Row(
          children: [
            CustomTextContainer(text: "MUSIC"),
            CustomTextContainer(text: "ECONOMICS"),
            CustomTextContainer(text: "ART"),
            CustomTextContainer(text: "POLITICS"),
          ],
        ),
        const Row(
          children: [
            CustomTextContainer(text: "NATURE"),
            CustomTextContainer(text: "HIKING"),
            CustomTextContainer(text: "FOOTBALL"),
            CustomTextContainer(text: "MOVIES"),
          ],
        ),
      ],
    );
  }
}
