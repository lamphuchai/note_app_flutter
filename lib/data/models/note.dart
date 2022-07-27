// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final int color;
  final DateTime createdAt;
  final DateTime updateAt;

  const Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.color,
      required this.createdAt,
      required this.updateAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'color': color,
      "createdAt": createdAt.toIso8601String(),
      "updateAt": createdAt.toIso8601String()
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'] as String,
        title: map['title'] as String,
        content: map['content'] as String,
        color: map['color'] as int,
        updateAt: DateTime.parse((map["updateAt"] as String)),
        createdAt: DateTime.parse(map["createdAt"] as String));
  }

  factory Note.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Note(
      id: doc.id,
      title: doc.data()!['title'] as String,
      content: doc.data()!['content'] as String,
      color: doc.data()!['color'] as int,
      updateAt: DateTime.parse((doc.data()!["updateAt"] as String)),
      createdAt: DateTime.parse((doc.data()!["createdAt"] as String)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(Map<String, dynamic> source) => Note.fromMap(source);

  Note copyWith({
    String? id,
    String? title,
    String? content,
    int? color,
    String? time,
    DateTime? updateAt,
    DateTime? createAt,
  }) {
    return Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        color: color ?? this.color,
        updateAt: updateAt ?? this.updateAt,
        createdAt: updateAt ?? this.updateAt);
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.color == color &&
        other.createdAt == createdAt &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        color.hashCode ^
        createdAt.hashCode ^
        updateAt.hashCode;
  }

  @override
  List<Object?> get props => [id, title, content, color, createdAt, updateAt];
}
