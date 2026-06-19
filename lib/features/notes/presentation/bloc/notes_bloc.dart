import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/note_entity.dart';
import '../../domain/usecases/add_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/update_note_usecase.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AddNoteUsecase addNoteUsecase;
  final GetNotesUsecase getNotesUsecase;
  final UpdateNoteUsecase updateNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;

  NotesBloc({
    required this.addNoteUsecase,
    required this.getNotesUsecase,
    required this.updateNoteUsecase,
    required this.deleteNoteUsecase,
  }) : super(NotesInitial()) {
    on<LoadNotesEvent>(_loadNotes);
    on<AddNoteEvent>(_addNote);
    on<UpdateNoteEvent>(_updateNote);
    on<DeleteNoteEvent>(_deleteNote);
  }

  Future<void> _loadNotes(
      LoadNotesEvent event,
      Emitter<NotesState> emit,
      ) async {
    emit(NotesLoading());

    try {
      final notes = await getNotesUsecase();

      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _addNote(
      AddNoteEvent event,
      Emitter<NotesState> emit,
      ) async {
    try {
      await addNoteUsecase(
        title: event.title,
        description: event.description,
      );

      final notes = await getNotesUsecase();

      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _updateNote(
      UpdateNoteEvent event,
      Emitter<NotesState> emit,
      ) async {
    try {
      await updateNoteUsecase(
        noteId: event.note.id,
        title: event.note.title,
        description: event.note.description,
      );

      final notes = await getNotesUsecase();

      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _deleteNote(
      DeleteNoteEvent event,
      Emitter<NotesState> emit,
      ) async {
    try {
      await deleteNoteUsecase(event.noteId);

      final notes = await getNotesUsecase();

      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}