import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start_date/blocs/profile/profile_bloc.dart';
import 'package:start_date/widgets/custom_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppbar(
        title: "START DATE",
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(100),
                            spreadRadius: 2.0,
                            blurRadius: 2.0,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Set Up Your Preferences",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const _GenderPreference(),
                    const SizedBox(height: 10.0),
                    const _AgeRangePreference(),
                    const SizedBox(height: 10.0),
                    const _DistancePreference(),
                  ],
                ),
              );
            } else {
              return const Text("Something went wrong");
            }
          },
        ),
      ),
    );
  }
}

class _DistancePreference extends StatelessWidget {
  const _DistancePreference({super.key});

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
              "Maximum Distance",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 100,
                    value: state.user.distancePreference!.toDouble(),
                    activeColor: Colors.black,
                    inactiveColor: Colors.amber,
                    onChanged: (value) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                distancePreference: value.toInt(),
                              ),
                            ),
                          );
                    },
                    onChangeEnd: (newValue) {
                      context.read<ProfileBloc>().add(
                            SaveProfile(
                              user: state.user.copyWith(
                                distancePreference: newValue.toInt(),
                              ),
                            ),
                          );
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    "${state.user.distancePreference} km",
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AgeRangePreference extends StatelessWidget {
  const _AgeRangePreference({super.key});

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
              "Age Range",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RangeSlider(
                    values: RangeValues(
                      state.user.ageRangePreference![0].toDouble(),
                      state.user.ageRangePreference![1].toDouble(),
                    ),
                    min: 18,
                    max: 100,
                    activeColor: Colors.black,
                    inactiveColor: Colors.amber,
                    onChanged: (rangeValues) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                ageRangePreference: [
                                  rangeValues.start.toInt(),
                                  rangeValues.end.toInt(),
                                ],
                              ),
                            ),
                          );
                    },
                    onChangeEnd: (newRangeValues) {
                      context.read<ProfileBloc>().add(
                            SaveProfile(
                              user: state.user.copyWith(
                                ageRangePreference: [
                                  newRangeValues.start.toInt(),
                                  newRangeValues.end.toInt(),
                                ],
                              ),
                            ),
                          );
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    "${state.user.ageRangePreference![0]} - ${state.user.ageRangePreference![1]}",
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _GenderPreference extends StatelessWidget {
  const _GenderPreference({super.key});

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
              "Show me:",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: state.user.genderPreference!.contains("Male"),
                  onChanged: (value) {
                    if (state.user.genderPreference!.contains("Male")) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..remove("Male"),
                              ),
                            ),
                          );
                      context
                          .read<ProfileBloc>()
                          .add(SaveProfile(user: state.user));
                    } else {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..add("Male"),
                              ),
                            ),
                          );
                      context
                          .read<ProfileBloc>()
                          .add(SaveProfile(user: state.user));
                    }
                  },
                ),
                const Text("Man"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: state.user.genderPreference!.contains("Female"),
                  onChanged: (value) {
                    if (state.user.genderPreference!.contains("Female")) {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..remove("Female"),
                              ),
                            ),
                          );
                      context
                          .read<ProfileBloc>()
                          .add(SaveProfile(user: state.user));
                    } else {
                      context.read<ProfileBloc>().add(
                            UpdateUserProfile(
                              user: state.user.copyWith(
                                genderPreference:
                                    List.from(state.user.genderPreference!)
                                      ..add("Female"),
                              ),
                            ),
                          );
                      context
                          .read<ProfileBloc>()
                          .add(SaveProfile(user: state.user));
                    }
                  },
                ),
                const Text("Woman"),
              ],
            ),
          ],
        );
      },
    );
  }
}
