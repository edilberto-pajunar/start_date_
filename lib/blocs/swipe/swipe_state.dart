part of 'swipe_bloc.dart';

sealed class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object> get props => [];
}

final class SwipeLoading extends SwipeState {}

final class SwipeLoaded extends SwipeState {
  final List<User> users;

  const SwipeLoaded({
    required this.users,
  });

  @override
  List<Object> get props => [users];
}

final class SwipeError extends SwipeState {}

class SwipeMatched extends SwipeState {
  final User user;

  const SwipeMatched({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
