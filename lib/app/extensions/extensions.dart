import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_flutter/data/models/models.dart';
import 'package:uuid/uuid.dart';

extension AppContext on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  int get defaultColorValue => Theme.of(this).backgroundColor.value;

  Note get createNote => Note(
      id: const Uuid().v1(),
      title: "",
      content: "",
      color: Theme.of(this).backgroundColor.value,
      createdAt: DateTime.now(),
      updateAt: DateTime.now());
}

extension StringX on String {
  Color get hexColor => Color(int.parse(replaceAll("#", "0xff")));
  String get timeNoteFormat =>
      DateFormat("dd-MM-yyyy,HH:mm").format(DateTime.now());
}

extension DateTimeX on DateTime {
  String get timeText => DateFormat("dd-MM-yyyy -- HH:mm").format(this);
}
