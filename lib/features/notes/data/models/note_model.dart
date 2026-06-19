import '../../domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  NoteModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.description,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NoteModel.fromFirestore(
      String id,
      Map<String, dynamic> json,
      ) {
    return NoteModel(
      id: id,
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}