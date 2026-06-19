import '../entities/note_entity.dart';

abstract class NotesRepository {
  Future<void> addNote({
    required String title,
    required String description,
  });

  Future<List<NoteEntity>> getNotes();

  Future<void> updateNote({
    required String noteId,
    required String title,
    required String description,
  });

  Future<void> deleteNote(String noteId);
}