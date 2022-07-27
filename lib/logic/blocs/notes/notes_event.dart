part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadingNotes extends NotesEvent{

}

class ChangeNotes extends NotesEvent {
  const ChangeNotes({required this.notes,required this.status});
  final NotesStatus status;

  final List<Note> notes;
  @override
  List<Object> get props => [notes,status];
}