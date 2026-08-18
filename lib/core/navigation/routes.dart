import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/search/search_screen.dart';
import '../../screens/library/library_screen.dart';
import '../../screens/upload/upload_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String search = '/search';
  static const String library = '/library';
  static const String upload = '/upload';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: library,
        builder: (context, state) => const LibraryScreen(),
      ),
      GoRoute(
        path: upload,
        builder: (context, state) => const UploadScreen(),
      ),
      GoRoute(
        path: profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
