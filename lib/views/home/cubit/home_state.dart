// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.isDeleteItems = false,
      this.listIdNotes = const [],
      this.selectAllNote = true});
  final bool isDeleteItems;
  final List<String> listIdNotes;
  final bool selectAllNote;

  @override
  List<Object> get props => [isDeleteItems, listIdNotes, selectAllNote];

  HomeState copyWith({
    bool? isDeleteItems,
    List<String>? listIdNotes,
    bool? selectAllNote,
  }) {
    return HomeState(
      isDeleteItems: isDeleteItems ?? this.isDeleteItems,
      listIdNotes: listIdNotes ?? this.listIdNotes,
      selectAllNote: selectAllNote ?? this.selectAllNote,
    );
  }
}
