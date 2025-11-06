import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocean_card/presentation/views/card/card_view.dart';

import '../../navegador.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/login/login_view.dart';

CustomTransitionPage customTransitionPage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 100),
  );
}

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      // ShellRoute para envolver las rutas principales con el Navegador
      ShellRoute(
        builder: (context, state, child) {
          return Navegador(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) {
              return customTransitionPage(const HomeView(), state);
            },
          ),
          GoRoute(
            path: '/card',
            pageBuilder: (context, state) {
              return customTransitionPage(const CardView(), state);
            },
          ),
        ],
      ),
      // Ruta para la vista de login
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return customTransitionPage(const LoginView(), state);
        },
      ),
      // Ruta catch-all para manejar páginas no encontradas
      GoRoute(
        path: '/:notFound(.*)',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Página no encontrada'))),
      ),
    ],
  );
}
