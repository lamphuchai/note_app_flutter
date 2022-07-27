// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

enum NotesStatus { loading, loaded }

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  const NotesLoaded({
    this.notes = const [],
  });
  final List<Note> notes;

  @override
  List<Object> get props => [notes];
}
