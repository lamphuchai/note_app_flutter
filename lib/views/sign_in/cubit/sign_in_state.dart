// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_cubit.dart';

enum SignInStatus { init, loading, success, error }

class SignInState extends Equatable {
  const SignInState(
      {this.email = Email.empty,
      this.password = Password.empty,
      this.status = SignInStatus.init,this.message = ""});
  final Email email;
  final Password password;
  final SignInStatus status;
  final String message;
  @override
  List<Object> get props => [email, password, status,message];

  SignInState copyWith({
    Email? email,
    Password? password,
    SignInStatus? status,
    String ? message
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
}
