import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_image_container.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PicturesTab extends StatelessWidget {
  const PicturesTab({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

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
          var images = state.user.imageUrls;
          var imageCount = images.length;
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
                    CustomTextHeader(
                      tabController: tabController,
                      text: "Add 2 or More Pictures",
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.66,
                        ),
                        itemBuilder: (context, index) {
                          return (imageCount > index)
                              ? CustomImageContainer(
                                  imageUrl: images[index],
                                )
                              : const CustomImageContainer();
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 4,
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
        } else {
          return const Text("Something went wrong.");
        }
      },
    );
  }
}
