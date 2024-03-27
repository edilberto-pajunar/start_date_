part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  final User user;
  final GoogleMapController? controller;

  const OnboardingLoaded({
    required this.user,
    this.controller,
  });
  @override
  List<Object?> get props => [user, controller];
}
