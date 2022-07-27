import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/models/note.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(
      {required Note note,
      required bool addNote,
      required NoteRepository repositoryIm})
      : _note = note,
        _noteRepositoryIm = repositoryIm,
        super(NoteState(note: note, addNote: addNote));

  final Note _note;
  final NoteRepository _noteRepositoryIm;

  void onChangeTitle(String text) {
    emit(state.copyWith(note: state.note.copyWith(title: text)));
  }

  void onChangeContent(String text) {
    emit(state.copyWith(note: state.note.copyWith(content: text)));
  }

  void onChangeColor(int value) {
    emit(state.copyWith(note: state.note.copyWith(color: value)));
  }

  void saveNote() {
    if (state.addNote) {
      if (state.note.content != "" || state.note.title != "") {
        _noteRepositoryIm.addNoteById(
            note: state.note.copyWith(createAt: DateTime.now()));
      }
    } else {
      if (_note != state.note) {
        _noteRepositoryIm.addNoteById(
            note: state.note.copyWith(updateAt: DateTime.now()));
      }
    }
  }
}
