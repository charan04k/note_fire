import '../../domain/entities/note_entity.dart';

abstract class NotesEvent {}

class LoadNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final String title;
  final String description;

  AddNoteEvent({
    required this.title,
    required this.description,
  });
}

class UpdateNoteEvent extends NotesEvent {
  final NoteEntity note;

  UpdateNoteEvent(this.note);
}

class DeleteNoteEvent extends NotesEvent {
  final String noteId;

  DeleteNoteEvent(this.noteId);
}