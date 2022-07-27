import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/data/models/models.dart';
import 'package:note_app_flutter/data/repositories/note_repository.dart';
import 'package:note_app_flutter/views/note/note.dart';

class MenuModalNote extends StatelessWidget {
  const MenuModalNote({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: BlocSelector<NoteCubit, NoteState, Note>(
        selector: (state) {
          return state.note;
        },
        builder: (context, note) {
          return IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => showModalBottomSheet(
                    backgroundColor: Color(note.color),
                    context: context,
                    builder: (context) => SafeArea(
                      child: Wrap(
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            height: 10,
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text("Xoá"),
                            onTap: () {
                              context
                                  .read<NoteRepository>()
                                  .deleteNoteById(idNote: note.id);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ));
        },
      ),
    );
  }
}
