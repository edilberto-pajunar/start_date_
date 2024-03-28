import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:start_date/blocs/onboarding/onboarding_bloc.dart';
import 'package:start_date/blocs/profile/profile_bloc.dart';
import 'package:start_date/models/location_model.dart';
import 'package:start_date/repositories/auth/auth_repository.dart';
import 'package:start_date/widgets/custom_appbar.dart';
import 'package:start_date/widgets/custom_elevated_button.dart';
import 'package:start_date/widgets/custom_text_container.dart';
import 'package:start_date/widgets/custom_text_field.dart';
import 'package:start_date/widgets/user_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: "PROFILE",
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  UserImage.medium(
                    height: 300,
                    url: state.user.imageUrls[0],
                    child: Container(
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Text(
                            state.user.name,
                            style: theme.textTheme.headlineLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CustomElevatedButton(
                          text: "View",
                          color:
                              state.isEditingOn ? Colors.white : Colors.black,
                          textColor:
                              state.isEditingOn ? Colors.black : Colors.white,
                          width: size.width * 0.45,
                          onPressed: () {
                            context
                                .read<ProfileBloc>()
                                .add(SaveProfile(user: state.user));
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomElevatedButton(
                          text: "Edit",
                          color:
                              !state.isEditingOn ? Colors.white : Colors.black,
                          textColor:
                              !state.isEditingOn ? Colors.black : Colors.white,
                          width: size.width * 0.45,
                          onPressed: () {
                            context.read<ProfileBloc>().add(const EditProfile(
                                  isEditingOn: true,
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TextField(
                          title: "Biography",
                          value: state.user.bio,
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                      user: state.user.copyWith(
                                    bio: value,
                                  )),
                                );
                          },
                        ),
                        _TextField(
                          title: "Age",
                          value: "${state.user.age}",
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            if (value == "") {
                              return;
                            }
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                      user: state.user.copyWith(
                                    age: int.parse(value),
                                  )),
                                );
                          },
                        ),
                        _TextField(
                          title: "Job Title",
                          value: state.user.jobTitle,
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                      user: state.user.copyWith(
                                    jobTitle: value,
                                  )),
                                );
                          },
                        ),
                        const _Pictures(),
                        const SizedBox(height: 10.0),
                        const _Interests(),
                        const SizedBox(height: 10.0),
                        _Location(
                          title: "Location",
                          value: state.user.location!.name,
                        ),
                        const SizedBox(height: 10.0),
                        const _SignOut(),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Text("Something went wrong.");
            }
          },
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.title,
    required this.onChanged,
    required this.value,
  });

  final String title;
  final String value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            state.isEditingOn
                ? CustomTextField(
                    initialValue: value,
                    onChanged: onChanged,
                  )
                : Text(
                    value,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
                  ),
            const SizedBox(height: 10.0),
          ],
        );
      },
    );
  }
}

class _Pictures extends StatelessWidget {
  const _Pictures({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pictures",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 125.0,
              child: ListView.builder(
                itemCount: state.user.imageUrls.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: UserImage.small(
                      url: state.user.imageUrls[index],
                      width: 100,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Interests extends StatelessWidget {
  const _Interests({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Interests",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Row(
              children: [
                CustomTextContainer(text: "MUSIC"),
                CustomTextContainer(text: "ECONOMICS"),
                CustomTextContainer(text: "FOOTBALL"),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SignOut extends StatelessWidget {
  const _SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                RepositoryProvider.of<AuthRepository>(context).signOut();
              },
              child: const Center(
                child: Text(
                  "Sign Out",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Location extends StatelessWidget {
  const _Location({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            state.isEditingOn
                ? CustomTextField(
                    initialValue: value,
                    hint: "ENTER YOUR LOCATION",
                    onChanged: (value) {
                      Location location =
                          state.user.location!.copyWith(name: value);
                      context
                          .read<ProfileBloc>()
                          .add(UpdateUserLocation(location: location));
                    },
                    onFocusChanged: (hasFocus) {
                      if (hasFocus) {
                        return;
                      } else {
                        context.read<ProfileBloc>().add(
                              UpdateUserLocation(
                                location: state.user.location,
                                isUpdateComplete: true,
                              ),
                            );
                      }
                    },
                  )
                : Text(
                    value,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
                  ),
            SizedBox(
              height: size.height * 0.5,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  context
                      .read<ProfileBloc>()
                      .add(UpdateUserLocation(controller: controller));
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
          ],
        );
      },
    );
  }
}
