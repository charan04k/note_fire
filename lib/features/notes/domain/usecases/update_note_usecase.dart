import '../repository/notes_repository.dart';

class UpdateNoteUsecase {
  final NotesRepository repository;

  UpdateNoteUsecase(this.repository);

  Future<void> call({
    required String noteId,
    required String title,
    required String description,
  }) {
    return repository.updateNote(
      noteId: noteId,
      title: title,
      description: description,
    );
  }
}