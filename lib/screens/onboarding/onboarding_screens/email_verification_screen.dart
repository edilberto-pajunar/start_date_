import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../widgets/custom_button.dart';

class EmailVerificationTab extends StatelessWidget {
  const EmailVerificationTab({
    super.key,
    required this.state,
  });

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
      currentStep: 3,
      onPressed: () {
        context
            .read<OnboardingBloc>()
            .add(ContinueOnboarding(user: state.user));
      },
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextHeader(
              text: "Did You Get the Verification Code?",
            ),
            CustomTextField(
              controller: TextEditingController(),
              hint: "ENTER YOUR CODE",
            ),
          ],
        ),
        const Column(
          children: [
            StepProgressIndicator(
              totalSteps: 6,
              currentStep: 2,
              selectedColor: Colors.black,
            ),
            SizedBox(height: 10.0),
            CustomButton(
              text: "Next",
            ),
          ],
        ),
      ],
    );
  }
}
