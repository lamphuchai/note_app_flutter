// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  const UserModel({
    required this.id,
    this.displayName,
    required this.email,
    this.photoUrl,
  });
  final String id;
  final String? displayName;
  final String email;
  final String? photoUrl;

  UserModel copyWith({
    String? id,
    String? displayName,
    String? email,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['uid'] as String,
      displayName: map['displayName'],
      email: map['email'],
      photoUrl: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, displayName: $displayName, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.displayName == displayName &&
        other.email == email &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        displayName.hashCode ^
        email.hashCode ^
        photoUrl.hashCode;
  }
}
