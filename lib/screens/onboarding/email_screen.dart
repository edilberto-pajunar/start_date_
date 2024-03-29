import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/cubits/signup/signup_cubit.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EmailTab extends StatelessWidget {
  const EmailTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          Column(
            children: [
              const StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Colors.black,
              ),
              const SizedBox(height: 10.0),
              CustomButton(
                text: "Next STEP",
                onPressed: () async {
                  await context
                      .read<SignupCubit>()
                      .signupWithCredentials()
                      .then((value) {
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
