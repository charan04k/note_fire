import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/register_file.dart';
import 'package:flutter/material.dart';


class WelcomePage extends StatelessWidget {
  final User user;

  const WelcomePage({
    super.key,
    required this.user,
  });

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterPage(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome ${user.email}",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => logout(context),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}