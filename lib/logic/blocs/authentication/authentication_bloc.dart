import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app_flutter/app/types/app_enum.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthenticationRepository authenRepository})
      : _authenRepository = authenRepository,
        super(const AuthenticationState()) {
    on<ChangeStatus>(_onChangeStatus);
    _streamSubscription = _authenRepository
        .status()
        .listen((status) => add(ChangeStatus(status)));
  }

  final AuthenticationRepository _authenRepository;
  late final StreamSubscription<AuthenticationStatus> _streamSubscription;

  void _onChangeStatus(ChangeStatus event, Emitter emit) {
    emit(AuthenticationState(status: event.status));
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
