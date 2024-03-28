part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends OnboardingEvent {
  final User user;

  const StartOnboarding({
    this.user = const User(
      id: "",
      name: "",
      age: 0,
      gender: "",
      imageUrls: [],
      bio: "",
      jobTitle: "",
      interests: [],
      location: Location.initialLocation,
    ),
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends OnboardingEvent {
  final User user;

  const UpdateUser({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final User? user;
  final XFile image;

  const UpdateUserImages({
    this.user,
    required this.image,
  });

  @override
  List<Object?> get props => [user, image];
}

class SetUserLocation extends OnboardingEvent {
  final Location? location;
  final GoogleMapController? controller;
  final bool isUpdateComplete;

  const SetUserLocation({
    this.location,
    this.controller,
    this.isUpdateComplete = false,
  });

  @override
  List<Object?> get props => [location, controller, isUpdateComplete];
}
