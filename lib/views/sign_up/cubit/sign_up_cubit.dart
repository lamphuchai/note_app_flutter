import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/core/exceptions/exceptions.dart';
import 'package:note_app_flutter/data/models/email.dart';
import 'package:note_app_flutter/data/models/password.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required AuthenticationRepository authenticationRepository})
      : _repository = authenticationRepository,
        super(const SignUpState());

  final AuthenticationRepository _repository;

  void onChangeEmail(String email) =>
      emit(state.copyWith(email: Email.validator(email)));

  void onChangePassword(String password) =>
      emit(state.copyWith(password: Password.validator(password)));

  Future<void> signUpWithEmail() async {
    final email = Email.validator(state.email.value);
    final password = Password.validator(state.password.value);
    if (email.errorText != null || password.errorText != null) {
      emit(state.copyWith(email: email, password: password));
    } else {
      try {
        emit(state.copyWith(status: SignUpStatus.loading));
        await _repository.signUpWithEmail(
            email: state.email.value, password: state.password.value);
        emit(state.copyWith(status: SignUpStatus.success));
      } on SignUpWithEmailFailure catch (e) {
        if (e.otherErr != null) {
          state.copyWith(status: SignUpStatus.error);
        } else {
          final email = state.email.copyWith(errorText: e.emailErr);
          final password = state.password.copyWith(errorText: e.passwordErr);
          emit(state.copyWith(
              email: email, password: password, status: SignUpStatus.success));
        }
      } catch (_) {
        state.copyWith(status: SignUpStatus.error);
      }
    }
  }
}
