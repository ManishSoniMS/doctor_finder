import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/intro_screens/on_boarding_screen.dart';
import '../features/authentication/presentation/screens/signin_screen.dart';
import '../features/intro_screens/splash_screen.dart';
import '../features/authentication/presentation/screens/doctor_register_screen.dart';
import '../features/authentication/presentation/screens/user_register_screen.dart';

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

@riverpod
GoRouter goRouter(Ref ref) {
  ref.keepAlive();
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
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
    ],
  );
}
