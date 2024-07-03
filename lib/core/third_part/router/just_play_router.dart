import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_in_play_proof/core/third_part/router/routes.dart';
import 'package:just_in_play_proof/features/auth/presenter/signin_screen/screen/signin_screen.dart';
import 'package:just_in_play_proof/features/auth/presenter/signup_screen/screen/signup_screen.dart';
import 'package:just_in_play_proof/features/auth/presenter/splash_screen/screen/splash_screen.dart';
import 'package:just_in_play_proof/features/home/presenter/homescreen/screen/home_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash.path,
      name: Routes.splash.name,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Routes.signIn.path,
          name: Routes.signIn.name,
          builder: (BuildContext context, GoRouterState state) {
            return const SignInScreen();
          },
        ),
        GoRoute(
          path: Routes.signUp.path,
          name: Routes.signUp.name,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: Routes.home.path,
          name: Routes.home.name,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
      ],
    ),
  ],
);
