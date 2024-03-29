import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/blocs/profile/profile_bloc.dart';
import 'package:start_date/screens/home/home_screen.dart';
import 'package:start_date/screens/login/login_screen.dart';
import 'package:start_date/widgets/custom_button.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:start_date/models/location_model.dart';

class LocationTab extends StatelessWidget {
  const LocationTab({
    super.key,
  });

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
                    const CustomTextHeader(
                      text: "Where Are You",
                    ),
                    CustomTextField(
                      onFocusChanged: (hasFocus) {
                        if (hasFocus) {
                          return;
                        } else {
                          context.read<OnboardingBloc>().add(SetUserLocation(
                                isUpdateComplete: true,
                                location: state.user.location,
                              ));
                        }
                      },
                      hint: "ENTER YOUR LOCATION",
                      onChanged: (val) {
                        Location location =
                            state.user.location!.copyWith(name: val);

                        context.read<OnboardingBloc>().add(SetUserLocation(
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
                        onMapCreated: (GoogleMapController mapController) {
                          context.read<OnboardingBloc>().add(
                              SetUserLocation(mapController: mapController));
                        },
                        initialCameraPosition: CameraPosition(
                          zoom: 10,
                          target: LatLng(
                            state.user.location!.lat.toDouble(),
                            state.user.location!.lon.toDouble(),
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
                      text: "DONE",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
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
