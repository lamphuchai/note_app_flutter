import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/core/exceptions/exceptions.dart';
import 'package:note_app_flutter/data/models/models.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required AuthenticationRepository authenticationRepository})
      : _repository = authenticationRepository,
        super(const SignInState());
  final AuthenticationRepository _repository;
  void onChangeEmail(String email) =>
      emit(state.copyWith(email: Email.validator(email)));

  void onChangePassword(String password) =>
      emit(state.copyWith(password: Password.validator(password)));

  Future<void> signInWithEmail() async {
    final email = Email.validator(state.email.value);
    final password = Password.validator(state.password.value);
    if (email.errorText != null || password.errorText != null) {
      emit(state.copyWith(email: email, password: password));
    } else {
      try {
        emit(state.copyWith(status: SignInStatus.loading));
        await _repository.signInWithEmail(
            email: state.email.value, password: state.password.value);
        emit(state.copyWith(status: SignInStatus.success));
      } on SignInWithEmailFailure catch (e) {
        if (e.otherErr != null) {
          state.copyWith(status: SignInStatus.error);
        } else {
          final email = state.email.copyWith(errorText: e.emailErr);
          final password = state.password.copyWith(errorText: e.passwordErr);
          emit(state.copyWith(
              email: email, password: password, status: SignInStatus.success));
        }
      } catch (_) {
        state.copyWith(status: SignInStatus.error);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _repository.signWithGoogle();
    } on SignInWithGoogleFailure catch (error) {
      emit(state.copyWith(message: error.message));
    } catch (error) {
      state.copyWith(status: SignInStatus.error);
    }
  }
}
