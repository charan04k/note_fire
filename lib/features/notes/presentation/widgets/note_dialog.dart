import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/note_entity.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';

class NoteDialog extends StatefulWidget {
  final NoteEntity? note;

  const NoteDialog({
    super.key,
    this.note,
  });

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.note?.title ?? "",
    );

    descriptionController = TextEditingController(
      text: widget.note?.description ?? "",
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.indigo,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        24,
        20,
        24,
        12,
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.indigo.shade100,
            child: Icon(
              widget.note == null
                  ? Icons.note_add_rounded
                  : Icons.edit_note_rounded,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.note == null
                  ? AppConstants.addNote
                  : AppConstants.editNote,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: width > 500 ? 450 : width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: inputDecoration(
                    label: AppConstants.noteTitle,
                    icon: Icons.title_rounded,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return AppConstants.titleIsRequired;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: inputDecoration(
                    label: AppConstants.description,
                    icon: Icons.description_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20,
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(AppConstants.cancel),
        ),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Icon(
            widget.note == null
                ? Icons.add
                : Icons.check,
          ),
          label: Text(
            widget.note == null
                ? AppConstants.addNote
                : AppConstants.updateNote,
          ),
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            if (widget.note == null) {
              context.read<NotesBloc>().add(
                AddNoteEvent(
                  title: titleController.text.trim(),
                  description:
                  descriptionController.text.trim(),
                ),
              );
            } else {
              context.read<NotesBloc>().add(
                UpdateNoteEvent(
                  NoteEntity(
                    id: widget.note!.id,
                    userId: widget.note!.userId,
                    title: titleController.text.trim(),
                    description:
                    descriptionController.text.trim(),
                    createdAt: widget.note!.createdAt,
                    updatedAt: DateTime.now(),
                  ),
                ),
              );
            }

            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}