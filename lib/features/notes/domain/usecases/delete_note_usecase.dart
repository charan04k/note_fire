import '../repository/notes_repository.dart';

class DeleteNoteUsecase {
  final NotesRepository repository;

  DeleteNoteUsecase(this.repository);

  Future<void> call(String noteId) {
    return repository.deleteNote(noteId);
  }
}