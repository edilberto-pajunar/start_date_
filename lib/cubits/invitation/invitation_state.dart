part of 'invitation_cubit.dart';

enum InvitationStatus { initial, submitting, failed, success }

class InvitationState extends Equatable {
  final String invitationCode;
  final InvitationStatus status;

  const InvitationState({
    required this.invitationCode,
    this.status = InvitationStatus.initial,
  });

  factory InvitationState.initial() {
    return const InvitationState(
      invitationCode: "",
      status: InvitationStatus.initial,
    );
  }

  @override
  List<Object> get props => [invitationCode];

  InvitationState copyWith({
    String? invitationCode,
    InvitationStatus? status,
  }) {
    return InvitationState(
      invitationCode: invitationCode ?? this.invitationCode,
      status: status ?? this.status,
    );
  }
}
