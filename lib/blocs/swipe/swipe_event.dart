part of 'swipe_bloc.dart';

sealed class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends SwipeEvent {}

class UpdateHome extends SwipeEvent {
  final List<User>? users;
  final User partner;

  const UpdateHome({
    required this.users,
    required this.partner,
  });

  @override
  List<Object?> get props => [users, partner];
}

class SwipeLeft extends SwipeEvent {
  final User currentUser;
  final User user;
  final User userPartner;

  const SwipeLeft({
    required this.currentUser,
    required this.user,
    required this.userPartner,
  });

  @override
  List<Object?> get props => [currentUser, user, userPartner];
}

class SwipeRight extends SwipeEvent {
  final User currentUser;
  final User user;
  final User userPartner;

  const SwipeRight({
    required this.currentUser,
    required this.user,
    required this.userPartner,
  });

  @override
  List<Object?> get props => [currentUser, user, userPartner];
}
