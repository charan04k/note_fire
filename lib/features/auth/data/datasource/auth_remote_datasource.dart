import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource({
    required this.auth,
    required this.firestore,
  });

  // Register
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential =
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = credential.user!;

    UserModel userModel = UserModel(
      // id: user.uid,
      name: name,
      email: email,
    );

    await firestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toJson());

    return userModel;
  }

  // Login
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential =
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = credential.user!;

    DocumentSnapshot document = await firestore
        .collection('users')
        .doc(user.uid)
        .get();

    Map<String, dynamic> data =
    document.data() as Map<String, dynamic>;

    return UserModel.fromJson(data, user.uid);
  }

  // Logout
  Future<void> logout() async {
    await auth.signOut();
  }
}