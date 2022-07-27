import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';
import 'package:note_app_flutter/logic/blocs/blocs.dart';
import 'package:note_app_flutter/views/home/home.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => HomeCubit(
            noteRepositoryIm: context.read<NoteRepository>()),
      ),
      BlocProvider(
        create: (context) =>
            NotesBloc(noteRepositoryIm: context.read<NoteRepository>())
              ..add(LoadingNotes()),
      )
    ], child: const HomePage());
  }
}
