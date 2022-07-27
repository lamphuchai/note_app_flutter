import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_flutter/views/note/note.dart';

class ContentNoteTextField extends StatefulWidget {
  const ContentNoteTextField({Key? key}) : super(key: key);

  @override
  State<ContentNoteTextField> createState() => _ContentNoteState();
}

class _ContentNoteState extends State<ContentNoteTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    final content = context.read<NoteCubit>().state.note.content;
    controller = TextEditingController(text: content);
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
          hintText: "Ghi chú",
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 16)),
      keyboardType: TextInputType.multiline,
      style: Theme.of(context).textTheme.bodyLarge,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      onChanged: (content) =>
          context.read<NoteCubit>().onChangeContent(content),
    );
  }
}
