part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}
