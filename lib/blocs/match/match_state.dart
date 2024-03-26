part of 'match_bloc.dart';

sealed class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

final class MatchLoading extends MatchState {}

final class MatchLoaded extends MatchState {
  final List<Match> matches;

  const MatchLoaded({
    required this.matches,
  });
  
  @override
  List<Object> get props => [matches];
}

final class MatchUnavailable extends MatchState {}
