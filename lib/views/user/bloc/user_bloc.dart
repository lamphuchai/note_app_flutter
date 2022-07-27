import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/models/user.dart';
import 'package:note_app_flutter/data/repositories/authentication_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required AuthenticationRepository repository})
      : super(UserState(UserModel(
            id: repository.firebaseAuth.currentUser!.uid,
            displayName: repository.firebaseAuth.currentUser!.displayName,
            email: repository.firebaseAuth.currentUser!.email!,
            photoUrl: repository.firebaseAuth.currentUser!.photoURL))) {
    on<ChangeUser>(_onChangeUser);
    _subscription =
        repository.firebaseAuth.userChanges().listen((userFirebase) {
      {
        if (userFirebase != null) {
          final user = UserModel(
              id: userFirebase.uid,
              displayName: userFirebase.displayName,
              email: userFirebase.email!,
              photoUrl: userFirebase.photoURL);
          add(ChangeUser(user));
        }
      }
    });
  }
  late final StreamSubscription _subscription;

  void _onChangeUser(ChangeUser event, Emitter emit) {
    emit(UserState(event.user));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
