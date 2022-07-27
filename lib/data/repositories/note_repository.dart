import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app_flutter/data/models/models.dart';

abstract class NoteRepositoryAbs {
  void initial(String id);
  Stream<List<Note>> get notes;
  Future<List<Note>> getAllNotes();
  Future<void> deleteNoteById({required String idNote});
  Future<void> updateNoteById({required Note note});
  Future<void> addNoteById({
    required Note note,
  });
}

class NoteRepository implements NoteRepositoryAbs {
  late CollectionReference<Map<String, dynamic>> _notesCollection;

  @override
  void initial(String id) {
    _notesCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("notes");
  }

  @override
  Stream<List<Note>> get notes {
    return _notesCollection
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((note) => Note.fromDocumentSnapshot(note))
            .toList());
  }

  @override
  Future<List<Note>> getAllNotes() async {
    final snapshot =
        await _notesCollection.orderBy("updateAt", descending: true).get();
    final notes =
        snapshot.docs.map((note) => Note.fromDocumentSnapshot(note)).toList();
    return notes;
  }

  @override
  Future<void> deleteNoteById({required String idNote}) async {
    final doc = _notesCollection.doc(idNote);
    await doc.delete();
  }

  Future<void> deleteMany({required List<String> listDeleteId}) async {
    for (var id in listDeleteId) {
      await deleteNoteById(idNote: id);
    }
  }

  @override
  Future<void> updateNoteById({required Note note}) async {
    final docs = _notesCollection.doc(note.id);
    await docs.set(note.toMap());
  }

  @override
  Future<void> addNoteById({
    required Note note,
  }) async {
    final docs = _notesCollection.doc(note.id);
    await docs.set(note.toMap());
  }
}
