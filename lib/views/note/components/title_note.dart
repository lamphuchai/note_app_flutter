import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/views/note/note.dart';

class TitleNoteTextField extends StatefulWidget {
  const TitleNoteTextField({Key? key}) : super(key: key);

  @override
  State<TitleNoteTextField> createState() => _TitleNoteTextFieldState();
}

class _TitleNoteTextFieldState extends State<TitleNoteTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    final title = context.read<NoteCubit>().state.note.title;
    controller = TextEditingController(text: title);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
          hintText: "Tiêu đề ...",
          helperStyle: TextStyle(fontSize: 18),
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 16)),
      keyboardType: TextInputType.multiline,
      style: Theme.of(context).textTheme.titleLarge,
      maxLines: null,
      onChanged: (title) => context.read<NoteCubit>().onChangeTitle(title),
    );
  }
}
