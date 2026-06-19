import '../../domain/entities/note_entity.dart';
import '../../domain/repository/notes_repository.dart';
import '../datasource/notes_remote_datasource.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDatasource remoteDatasource;

  NotesRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> addNote({
    required String title,
    required String description,
  }) {
    return remoteDatasource.addNote(
      title: title,
      description: description,
    );
  }

  @override
  Future<List<NoteEntity>> getNotes() {
    return remoteDatasource.getNotes();
  }

  @override
  Future<void> updateNote({
    required String noteId,
    required String title,
    required String description,
  }) {
    return remoteDatasource.updateNote(
      noteId: noteId,
      title: title,
      description: description,
    );
  }

  @override
  Future<void> deleteNote(String noteId) {
    return remoteDatasource.deleteNote(noteId);
  }
}