import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_text_container.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Bio extends StatelessWidget {
  const Bio({
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
                text: "Describe Yourself a Bit",
              ),
              CustomTextField(
                controller: TextEditingController(),
                text: "ENTER YOUR BIO",
              ),
              const SizedBox(height: 100.0),
              CustomTextHeader(
                tabController: tabController,
                text: "What Do You Like?",
              ),
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
