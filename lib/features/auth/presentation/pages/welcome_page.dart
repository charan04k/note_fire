import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

import 'login_page.dart';

class WelcomePage extends StatelessWidget {

  final UserEntity user;

  const WelcomePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(

      listener: (context, state) {

        if (state is AuthLoggedOut) {

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginPage(),
            ),
                (route) => false,
          );
        }
      },

      child: Scaffold(

        appBar: AppBar(
          title: const Text("Welcome"),
        ),

        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Text(
                "Welcome ${user.name}",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 10),

              Text(user.email),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {

                  context.read<AuthBloc>().add(
                    LogoutEvent(),
                  );
                },
                child: const Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}