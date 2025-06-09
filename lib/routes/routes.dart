import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentication/data/auth_repository.dart';
import '../features/intro_screens/on_boarding_screen.dart';
import '../features/authentication/presentation/screens/signin_screen.dart';
import '../features/intro_screens/splash_screen.dart';
import '../features/authentication/presentation/screens/doctor_register_screen.dart';
import '../features/authentication/presentation/screens/user_register_screen.dart';
import '../features/user_management/presentation/screens/main_screen.dart';
import 'go_router_refresh_stream.dart';

part 'routes.g.dart';

enum AppRoute {
  splash,
  onboarding,
  signin,
  main,
  doctorRegister,
  userRegister,
  doctorDetails,
  account,
  chat,
  conversation,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = firebaseAuth.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn &&
          (path == '/sign-in' ||
              path == '/user-register' ||
              path == '/doctor-register')) {
        return '/main';
      } else if (!isLoggedIn &&
          (path.contains('/main') || path.contains('/account'))) {
        return '/sign-in';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(firebaseAuth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoute.splash.name,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/on-boarding',
        name: AppRoute.onboarding.name,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signin.name,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/user-register',
        name: AppRoute.userRegister.name,
        builder: (context, state) => UserRegisterScreen(),
      ),
      GoRoute(
        path: '/doctor-register',
        name: AppRoute.doctorRegister.name,
        builder: (context, state) => DoctorRegisterScreen(),
      ),
      GoRoute(
        path: '/main',
        name: AppRoute.main.name,
        builder: (context, state) => MainScreen(),
      ),
    ],
  );
}
