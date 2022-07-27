import 'package:flutter/material.dart';
import 'package:note_app_flutter/app/extensions/extensions.dart';
import 'package:note_app_flutter/data/models/models.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      color: Color(note.color),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (note.title.isNotEmpty) ...[
              Text(
                note.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (note.content.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.only(bottom: 5),
                constraints: BoxConstraints(
                  maxHeight: size.height * 1 / 4,
                  minHeight: 20,
                ),
                child: Text(
                  note.content,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
            const SizedBox(
              height: 5,
            ),
            Text(
              note.updateAt.timeText,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
