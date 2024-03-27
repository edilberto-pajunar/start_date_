import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/cubits/signup/signup_cubit.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EmailTab extends StatelessWidget {
  const EmailTab({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextHeader(
                    tabController: tabController,
                    text: "What's Your Email Address",
                  ),
                  CustomTextField(
                    text: "ENTER YOUR EMAIL",
                    onChanged: (val) {
                      context.read<SignupCubit>().emailChanged(val);
                      print(state.email);
                    },
                  ),
                  const SizedBox(height: 100),
                  CustomTextHeader(
                    tabController: tabController,
                    text: "Choose a Password",
                  ),
                  CustomTextField(
                    text: "ENTER YOUR PASSWORD",
                    onChanged: (val) {
                      context.read<SignupCubit>().passwordChanged(val);
                      print(state.password);
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
                    tabController: tabController,
                    text: "Next",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
