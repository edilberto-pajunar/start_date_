part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String userId;

  const LoadProfile({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class EditProfile extends ProfileEvent {
  final bool isEditingOn;

  const EditProfile({
    required this.isEditingOn,
  });

  @override
  List<Object?> get props => [isEditingOn];
}

class SaveProfile extends ProfileEvent {
  final User user;

  const SaveProfile({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUserProfile extends ProfileEvent {
  final User user;

  const UpdateUserProfile({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUserLocation extends ProfileEvent {
  final Location? location;
  final GoogleMapController? controller;
  final bool isUpdateComplete;

  const UpdateUserLocation({
    this.location,
    this.controller,
    this.isUpdateComplete = false,
  });

  @override
  List<Object?> get props => [location, controller, isUpdateComplete];
}

class GenerateCode extends ProfileEvent {}
