import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required NoteRepository noteRepositoryIm})
      : _repositoryIm = noteRepositoryIm,
        super(const HomeState());

  final NoteRepository _repositoryIm;

  void closeDeleteNotes() =>
      emit(state.copyWith(isDeleteItems: false, listIdNotes: []));

  void selectNoteId(String idNote) {
    final checkItem = state.listIdNotes.contains(idNote);
    if (checkItem) {
      final listIdNotes =
          state.listIdNotes.where((id) => id != idNote).toList();
      emit(state.copyWith(listIdNotes: listIdNotes));
    } else {
      emit(state.copyWith(listIdNotes: [
        ...state.listIdNotes,
        idNote,
      ], isDeleteItems: true));
    }
  }

  void onLongPress(String idNote) {
    if (state.isDeleteItems) {
      final listIdNotes =
          state.listIdNotes.where((id) => id != idNote).toList();
      emit(state.copyWith(listIdNotes: listIdNotes));
    } else {
      emit(state.copyWith(listIdNotes: [
        ...state.listIdNotes,
        idNote,
      ], isDeleteItems: true));
    }
  }

  void actionType(String type, {List<String>? listId}) {
    switch (type) {
      case "select-all":
        emit(state.copyWith(listIdNotes: listId, selectAllNote: false));
        break;
      case "unselect-all":
        emit(state.copyWith(listIdNotes: [], selectAllNote: true));
        break;
      default:
        break;
    }
  }

  Future<void> deleteManyNote() async {
    await _repositoryIm.deleteMany(listDeleteId: state.listIdNotes);
    emit(state.copyWith(isDeleteItems: false));
  }
}
