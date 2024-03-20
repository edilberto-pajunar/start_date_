import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:start_date/models/user_model.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<SwipeRightEvent>(_onSwipeRight);
    on<SwipeLeftEvent>(_onSwipeLeft);
  }

  void _onLoadUsers(LoadUsersEvent event, emit) {
    emit(SwipeLoaded(users: event.users));
  }

  void _onSwipeRight(SwipeRightEvent event, emit) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      try {
        emit(
          SwipeLoaded(users: List.from(state.users)..remove(event.user)),
        );
      } catch (_) {}
    }
  }

  void _onSwipeLeft(SwipeLeftEvent event, emit) {
    if (state is SwipeLoaded) {
      try {
        final state = this.state as SwipeLoaded;
        emit(
          SwipeLoaded(users: List.from(state.users)..remove(event.user)),
        );
      } catch (_) {}
    }
  }
}
