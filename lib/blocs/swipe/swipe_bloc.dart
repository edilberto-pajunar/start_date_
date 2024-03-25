import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/database/database_repository.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;

  SwipeBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateHome>(_onUpdateHome);
    on<SwipeRight>(_onSwipeRight);
    on<SwipeLeft>(_onSwipeLeft);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        add(LoadUsers(user: state.user!));
      }
    });
  }

  void _onLoadUsers(LoadUsers event, emit) {
    List<String> userFilter = List.from(event.user.swipeLeft!)
      ..addAll(event.user.swipeRight!)
      ..add(event.user.id!);

    _databaseRepository.getUsers(event.user).listen((users) {
      print("Loading Users: $users");
      add(UpdateHome(
        users:
            users.where((element) => !userFilter.contains(element.id)).toList(),
      ));
    });
  }

  void _onUpdateHome(UpdateHome event, emit) {
    if (event.users!.isNotEmpty) {
      emit(SwipeLoaded(users: event.users!));
    } else {
      emit(SwipeError());
    }
  }

  void _onSwipeRight(SwipeRight event, emit) async {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      final String userId = _authBloc.state.authUser!.uid;
      List<User> users = List.from(state.users)..remove(event.user);

      await _databaseRepository.updateUserSwipe(
        userId,
        event.user.id!,
        true,
      );

      if (!event.user.swipeRight!.contains(userId)) {
        await _databaseRepository.updateUserMatch(userId, event.user.id!);
        emit(SwipeMatched(user: event.user));
      } else if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  void _onSwipeLeft(SwipeLeft event, emit) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      List<User> users = List.from(state.users)..remove(event.user);

      _databaseRepository.updateUserSwipe(
        _authBloc.state.authUser!.uid,
        event.user.id!,
        false,
      );

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
