part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final bool isEditingOn;
  final GoogleMapController? controller;
  final String? generatedCode;

  const ProfileLoaded({
    required this.user,
    this.isEditingOn = false,
    this.controller,
    this.generatedCode,
  });

  @override
  List<Object?> get props => [user, isEditingOn, controller, generatedCode];
}