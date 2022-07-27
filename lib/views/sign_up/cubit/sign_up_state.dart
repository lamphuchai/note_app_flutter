// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

enum SignUpStatus { init, loading, success, error }

class SignUpState extends Equatable {
  const SignUpState({this.email = Email.empty, this.password = Password.empty,this.status = SignUpStatus.init});
  final Email email;
  final Password password;
  final SignUpStatus status;
  @override
  List<Object> get props => [email, password,status];

  SignUpState copyWith({
    Email? email,
    Password? password,
    SignUpStatus? status
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status:  status ?? this.status
    );
  }
}
