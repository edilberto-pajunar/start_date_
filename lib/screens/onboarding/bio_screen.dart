import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_text_container.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BioTab extends StatelessWidget {
  const BioTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    const CustomTextHeader(
                      text: "Describe Yourself a Bit",
                    ),
                    CustomTextField(
                      hint: "ENTER YOUR BIO",
                      onChanged: (val) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(user: state.user.copyWith(bio: val)),
                            );
                      },
                    ),
                     const CustomTextHeader(
                      text: "What do you do?",
                    ),
                    CustomTextField(
                      hint: "ENTER YOUR JOB TITLE",
                      onChanged: (val) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(user: state.user.copyWith(jobTitle: val)),
                            );
                      },
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
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 5,
                      selectedColor: Colors.black,
                    ),
                    const SizedBox(height: 10.0),
                    CustomButton(
                      text: "Next",
                      onPressed: () {
                        context
                            .read<OnboardingBloc>()
                            .add(ContinueOnboarding(user: state.user));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Text("Something went wrong.");
        }
      },
    );
  }
}
