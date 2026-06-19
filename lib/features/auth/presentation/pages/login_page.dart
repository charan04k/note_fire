import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../notes/presentation/pages/dashboard_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import 'register_page.dart';
import 'welcome_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    context.read<AuthBloc>().add(
      LoginEvent(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: BlocConsumer<AuthBloc, AuthState>(

        listener: (context, state) {

          if (state is AuthSuccess) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => DashboardPage(),
              ),
            );
          }

          if (state is AuthFailure) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },

        builder: (context, state) {

          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [

                TextField(
                  controller: emailController,
                  decoration:
                  const InputDecoration(labelText: "Email"),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration:
                  const InputDecoration(labelText: "Password"),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: login,
                  child: const Text("Login"),
                ),

                TextButton(
                  onPressed: () {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text("Create Account"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}