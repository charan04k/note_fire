import 'package:firebase_note/features/test_nav/route_app.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final params = (state.extra as Map<String, dynamic>?) ?? {};
        return const ProfilePage();
      },
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final params = (state.extra as Map<String, dynamic>?) ?? {};
        return  DetailsPage(params: params);
      },
    ),
  ],
);