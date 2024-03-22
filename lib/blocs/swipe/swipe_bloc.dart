import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start_date/models/user_model.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<SwipeRight>(_onSwipeRight);
    on<SwipeLeft>(_onSwipeLeft);
  }

  void _onLoadUsers(LoadUsers event, emit) {
    emit(SwipeLoaded(users: event.users));
  }

  void _onSwipeRight(SwipeRight event, emit) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      try {
        emit(
          SwipeLoaded(users: List.from(state.users)..remove(event.user)),
        );
      } catch (_) {}
    }
  }

  void _onSwipeLeft(SwipeLeft event, emit) {
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
