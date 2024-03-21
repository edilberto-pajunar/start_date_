import 'package:flutter/material.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_checkbox.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Demo extends StatelessWidget {
  const Demo({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

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
              CustomTextHeader(
                tabController: tabController,
                text: "What's Your Gender?",
              ),
              const SizedBox(height: 10.0),
              CustomCheckbox(tabController: tabController, text: "MALE"),
              CustomCheckbox(tabController: tabController, text: "FEMALE"),
              const SizedBox(height: 100.0),
              CustomTextHeader(
                tabController: tabController,
                text: "What's Your Age?",
              ),
              CustomTextField(
                text: "ENTER YOUR AGE",
                controller: TextEditingController(),
              ),
            ],
          ),
          Column(
            children: [
              const StepProgressIndicator(
                totalSteps: 6,
                currentStep: 3,
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
  }
}
