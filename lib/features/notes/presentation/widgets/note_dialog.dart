import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.note == null ? "Add Note" : "Edit Note",
      ),

      content: Form(
        key: _formKey,

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              TextFormField(
                controller: titleController,

                decoration: const InputDecoration(
                  labelText: "Title",
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: descriptionController,

                maxLines: 4,

                decoration: const InputDecoration(
                  labelText: "Description",
                ),
              ),
            ],
          ),
        ),
      ),

      actions: [

        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: () {

            if (!_formKey.currentState!.validate()) {
              return;
            }

            if (widget.note == null) {

              context.read<NotesBloc>().add(
                AddNoteEvent(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                ),
              );

            } else {

              context.read<NotesBloc>().add(

                UpdateNoteEvent(

                  NoteEntity(
                    id: widget.note!.id,
                    userId: widget.note!.userId,
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    createdAt: widget.note!.createdAt,
                    updatedAt: DateTime.now(),
                  ),
                ),
              );
            }

            Navigator.pop(context);
          },

          child: Text(
            widget.note == null ? "Add" : "Update",
          ),
        ),
      ],
    );
  }
}