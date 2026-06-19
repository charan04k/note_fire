import '../repository/notes_repository.dart';

class AddNoteUsecase {
  final NotesRepository repository;

  AddNoteUsecase(this.repository);

  Future<void> call({
    required String title,
    required String description,
  }) {
    return repository.addNote(
      title: title,
      description: description,
    );
  }
}