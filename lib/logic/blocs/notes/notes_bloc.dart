import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/models/models.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc({required NoteRepository noteRepositoryIm})
      : super(NotesInitial()) {
    on<LoadingNotes>(_onLoadingNotes);
    on<ChangeNotes>(_onChangeNotes);
    _subscription = noteRepositoryIm.notes.listen((notes) {
      add(ChangeNotes(notes: notes, status: NotesStatus.loaded));
    });
  }
  late StreamSubscription _subscription;

  void _onLoadingNotes(LoadingNotes event, Emitter<NotesState> emit) =>
      emit(NotesLoading());

  void _onChangeNotes(ChangeNotes event, Emitter<NotesState> emit) =>
      emit(NotesLoaded(notes: event.notes));

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
