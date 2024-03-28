import 'package:flutter/material.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/custom_button.dart';

class EmailVerificationTab extends StatelessWidget {
  const EmailVerificationTab({
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
                text: "Did You Get the Verification Code?",
              ),
              CustomTextField(
                controller: TextEditingController(),
                hint: "ENTER YOUR CODE",
              ),
            ],
          ),
          Column(
            children: [
              const StepProgressIndicator(
                totalSteps: 6,
                currentStep: 2,
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
