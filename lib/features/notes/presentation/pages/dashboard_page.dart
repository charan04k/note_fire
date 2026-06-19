import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';

import '../../../auth/presentation/pages/login_page.dart';
import '../widgets/note_dialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();

    context.read<NotesBloc>().add(
      LoadNotesEvent(),
    );
  }

  Future<void> logout() async {

    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Dashboard"),

        actions: [

          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog(

            context: context,

            builder: (_) {

              return BlocProvider.value(
                value: context.read<NotesBloc>(),
                child: const NoteDialog(),
              );

            },
          );

        },
        child: const Icon(Icons.add),
      ),

      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {

          if (state is NotesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NotesLoaded) {

            return Padding(
              padding: const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(
                    "Welcome ${user?.email}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Total Notes : ${state.notes.length}",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  if (state.notes.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          "No Notes Yet\nClick + to Add Note",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(

                        itemCount: state.notes.length,

                        itemBuilder: (context, index) {

                          final note = state.notes[index];

                          return Card(

                            child: ListTile(

                              title: Text(note.title),

                              subtitle: Text(note.description),

                              trailing: Row(

                                mainAxisSize: MainAxisSize.min,

                                children: [

                                  IconButton(

                                    icon: const Icon(Icons.edit),

                                    onPressed: () {

                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return BlocProvider.value(
                                            value: context.read<NotesBloc>(),
                                            child: NoteDialog(
                                              note: note,
                                            ),
                                          );
                                        },
                                      );

                                    },
                                  ),

                                  IconButton(

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),

                                    onPressed: () {

                                      showDialog(

                                        context: context,

                                        builder: (_) {

                                          return AlertDialog(

                                            title: const Text(
                                              "Delete Note",
                                            ),

                                            content: const Text(
                                              "Are you sure?",
                                            ),

                                            actions: [

                                              TextButton(

                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },

                                                child: const Text(
                                                  "Cancel",
                                                ),
                                              ),

                                              ElevatedButton(

                                                onPressed: () {

                                                  context.read<NotesBloc>().add(
                                                    DeleteNoteEvent(
                                                      note.id,
                                                    ),
                                                  );

                                                  Navigator.pop(context);

                                                },

                                                child: const Text(
                                                  "Delete",
                                                ),
                                              ),

                                            ],
                                          );
                                        },
                                      );

                                    },
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                ],
              ),
            );
          }

          if (state is NotesError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}