import 'package:flutter/material.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Email extends StatelessWidget {
  const Email({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                controller: emailController,
                text: "ENTER YOUR EMAIL",
              ),
              const SizedBox(height: 100),
              CustomTextHeader(
                tabController: tabController,
                text: "Choose a Password",
              ),
              CustomTextField(
                controller: passwordController,
                text: "ENTER YOUR PASSWORD",
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
                emailController: emailController,
                passwordController: passwordController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}