import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/note_model.dart';

class NotesRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  NotesRemoteDatasource({
    required this.firestore,
    required this.auth,
  });

  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    final uid = auth.currentUser!.uid;

    await firestore.collection('notes').add({
      'userId': uid,
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<NoteModel>> getNotes() async {
    final uid = auth.currentUser!.uid;

    print("object $uid");

    final snapshot = await firestore
        .collection('notes')
        .where('userId', isEqualTo: uid)
        .get();
    
    print(snapshot.docs.map((doc)=>doc.id));
    print(snapshot.docs.map((doc)=>doc.data()));

    return snapshot.docs
        .map((doc) => NoteModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }
  Future<void> updateNote({
    required String noteId,
    required String title,
    required String description,
  }) async {
    print("noteId $noteId");
    await firestore.collection('notes').doc(noteId).update({
      'title': title,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteNote(String noteId) async {
    await firestore.collection('notes').doc(noteId).delete();
  }
}