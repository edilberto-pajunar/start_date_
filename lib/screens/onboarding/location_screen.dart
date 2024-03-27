import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:start_date/models/location_model.dart';

class LocationTab extends StatelessWidget {
  const LocationTab({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                    CustomTextHeader(
                      tabController: tabController,
                      text: "Where Are You",
                    ),
                    CustomTextField(
                      onFocusChanged: (hasFocus) {
                        if (hasFocus) {
                          return;
                        } else {
                          context.read<OnboardingBloc>().add(UpdateUserLocation(
                                isUpdateComplete: true,
                                location: state.user.location,
                              ));
                        }
                      },
                      text: "ENTER YOUR LOCATION",
                      onChanged: (val) {
                        Location location =
                            state.user.location!.copyWith(name: val);

                        context.read<OnboardingBloc>().add(UpdateUserLocation(
                              location: location,
                            ));
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: size.height * 0.5,
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: false,
                        onMapCreated: (GoogleMapController controller) {
                          context.read<OnboardingBloc>().add(
                                UpdateUserLocation(
                                  controller: controller,
                                ),
                              );
                        },
                        initialCameraPosition: CameraPosition(
                          zoom: 10,
                          target: LatLng(
                            state.user.location!.lat,
                            state.user.location!.lon,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 6,
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
