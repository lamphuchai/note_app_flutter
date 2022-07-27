import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';
import 'package:note_app_flutter/data/models/models.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';
import 'package:note_app_flutter/views/note/note.dart';

class NoteView extends StatelessWidget {
  const NoteView({Key? key, this.note}) : super(key: key);
  final Note? note;
  @override
  Widget build(BuildContext context) {
    final noteTmp = note ?? context.createNote;
    return BlocProvider(
      create: (context) => NoteCubit(
          note: noteTmp,
          repositoryIm: context.read<NoteRepository>(),
          addNote: note == null ? true : false),
      child: const NotePage(),
    );
  }
}
