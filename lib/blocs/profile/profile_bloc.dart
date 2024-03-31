import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/models/location_model.dart';
import 'package:start_date/models/user_model.dart';
import 'package:start_date/repositories/database/database_repository.dart';
import 'package:start_date/repositories/location/location_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  final LocationRepository _locationRepository;
  StreamSubscription? _authSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
    required LocationRepository locationRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        _locationRepository = locationRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<EditProfile>(_onEditProfile);
    on<SaveProfile>(_onSaveProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UpdateUserLocation>(_onUpdateUserLocation);
    on<GenerateCode>(_onGenerateCode);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadProfile(userId: state.authUser!.uid));
      }
    });
  }

  void _onLoadProfile(LoadProfile event, emit) async {
    User user = await _databaseRepository.getUser(event.userId).first;
    emit(ProfileLoaded(user: user));
  }

  void _onEditProfile(EditProfile event, emit) {
    if (state is ProfileLoaded) {
      emit(
        ProfileLoaded(
          user: (state as ProfileLoaded).user,
          isEditingOn: event.isEditingOn,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onSaveProfile(SaveProfile event, emit) {
    if (state is ProfileLoaded) {
      _databaseRepository.updateUser((state as ProfileLoaded).user);

      emit(
        ProfileLoaded(
          user: (state as ProfileLoaded).user,
          isEditingOn: false,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onUpdateUserProfile(UpdateUserProfile event, emit) {
    if (state is ProfileLoaded) {
      emit(
        ProfileLoaded(
          user: event.user,
          isEditingOn: (state as ProfileLoaded).isEditingOn,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onUpdateUserLocation(UpdateUserLocation event, emit) async {
    final state = this.state as ProfileLoaded;

    if (event.isUpdateComplete && event.location != null) {
      final Location location =
          await _locationRepository.getLocation(event.location!.name);

      state.controller!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            location.lat.toDouble(),
            location.lon.toDouble(),
          ),
        ),
      );

      add(UpdateUserProfile(user: state.user.copyWith(location: location)));
    } else {
      emit(
        ProfileLoaded(
          user: state.user.copyWith(location: event.location),
          isEditingOn: (state).isEditingOn,
          controller: (state).controller,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }

  void _onGenerateCode(GenerateCode event, emit) async {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String code = '';

    for (int i = 0; i < 4; i++) {
      code += chars[random.nextInt(chars.length)];
    }
    final state = this.state as ProfileLoaded;

    await _databaseRepository.updateCode(state.user, code);

    emit(ProfileLoaded(
      user: state.user,
      generatedCode: code,
    ));
  }
}
