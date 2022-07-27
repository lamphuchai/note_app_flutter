part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class ChangeUser extends UserEvent {
  const ChangeUser(this.user);
  final UserModel user;

  @override
  List<Object> get props => [user];
}
