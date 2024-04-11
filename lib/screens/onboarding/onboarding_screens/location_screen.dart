import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/screens/onboarding/onboarding_screen.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/custom_text_header.dart';
import 'package:start_date/models/location_model.dart';

class LocationTab extends StatelessWidget {
  const LocationTab({
    super.key,
    required this.state,
  });

  final OnboardingLoaded state;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return OnboardingScreenLayout(
      currentStep: 6,
      onPressed: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
        context.read<AuthBloc>().add(AuthUserChanged(
            authUser: context.read<AuthBloc>().state.authUser!));
      },
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
            Location location = state.user.location!.copyWith(name: val);

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
              context
                  .read<OnboardingBloc>()
                  .add(SetUserLocation(mapController: mapController));
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
    );
  }
}
