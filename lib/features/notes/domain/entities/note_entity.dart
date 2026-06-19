class NoteEntity {
  final String id;
  final String userId;
  final String title;
  final String description;
  final dynamic createdAt;
  final dynamic updatedAt;

  NoteEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}