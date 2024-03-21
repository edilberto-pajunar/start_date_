import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<auth.User?>? _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    _userSubscription = _authRepository.user.listen((user) {
      add(AuthUserChanged(user: user!));
    });
    on<AuthUserChanged>(_onAuthUserChanged);
  }

  void _onAuthUserChanged(AuthUserChanged event, emit) {
    emit(AuthState.authenticated(user: event.user));
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
