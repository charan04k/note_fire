import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/notes/presentation/bloc/notes_bloc.dart';
import 'features/notes/presentation/pages/dashboard_page.dart';
import 'features/push_notification/push_notification.dart';
import 'features/test_nav/route_app.dart';
import 'features/test_nav/routing.dart';
import 'firebase_options.dart';
import 'injection_container.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await NotificationService.initialize();
  } catch (e, stackTrace) {
    print("Notification Error: $e");
    print(stackTrace);
  }

  await init();

  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp2());
// }

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<NotesBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginPage()
            : const DashboardPage(),
      ),
    );
  }
}