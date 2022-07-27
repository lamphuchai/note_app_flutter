// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_cubit.dart';

class NoteState extends Equatable {
  const NoteState({required this.note, required this.addNote});
  final Note note;
  final bool addNote;

  @override
  List<Object> get props => [note];

  NoteState copyWith({
    Note? note,
    bool? addNote,
  }) {
    return NoteState(
      note: note ?? this.note,
      addNote: addNote ?? this.addNote,
    );
  }
}
