part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class ChangeStatus extends AuthenticationEvent {
  const ChangeStatus(this.status);
  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}
