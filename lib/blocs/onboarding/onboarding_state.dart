part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  final User user;
  final GoogleMapController? mapController;
  final TabController tabController;

  const OnboardingLoaded({
    required this.user,
    required this.tabController,
    this.mapController,
  });
  @override
  List<Object?> get props => [user, mapController, tabController];
}
