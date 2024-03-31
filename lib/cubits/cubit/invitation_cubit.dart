import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start_date/blocs/auth/auth_bloc.dart';
import 'package:start_date/repositories/auth/auth_repository.dart';
import 'package:start_date/repositories/database/database_repository.dart';

part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  final DatabaseRepository _databaseRepository;
  final AuthBloc _authBloc;

  InvitationCubit({
    required DatabaseRepository databaseRepository,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(InvitationState.initial());

  void invitationCodeChanged(String value) {
    emit(state.copyWith(invitationCode: value));
    print(state.invitationCode);
  }

  Future<void> joinPartner() async {
    if (state.status == InvitationStatus.submitting) return;
    emit(state.copyWith(status: InvitationStatus.submitting));

    try {
      await _databaseRepository.updateJoinPartner(
        _authBloc.state.user!,
        state.invitationCode,
      );
      emit(state.copyWith(status: InvitationStatus.success));
    } catch (_) {
      emit(state.copyWith(status: InvitationStatus.failed));
    }
  }
}
