import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:watso_v2/common/router/routes.dart';
import 'package:watso_v2/common/user/user_provider.dart';
import 'package:watso_v2/common/widgets/Layout.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter myRouter(ref) {
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(() => isAuth.dispose())
    ..listen(authControllerProvider, (_, authValue) {
      // isAuthValue is null
      log('authValue: ${authValue.value}');
      if (authValue.value == null) {
        isAuth.value = const AsyncData(false);
      } else {
        isAuth.value = const AsyncData(true);
      }
      log('isAuth: ${isAuth.value.value}');
    });

  return GoRouter(
      routes: _routes,
      navigatorKey: _rootNavigatorKey,
      initialLocation: Routes.splash.path,
      refreshListenable: isAuth,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        // 유저 정보를 불러올때까지 로딩...
        if (isAuth.value.isLoading || !isAuth.value.hasValue) {
          return Routes.splash.path;
        }

        final auth = isAuth.value.requireValue;
        if (state.uri.path == Routes.splash.path) {
          return auth ? Routes.tMain.path : Routes.login.path;
        }
        if (state.uri.path == Routes.login.path) {
          return auth ? Routes.tMain.path : null;
        }
        return auth ? null : Routes.login.path;
      });
}
// splash screen 만들어야함.

final List<RouteBase> _routes = [
  GoRoute(
    path: Routes.splash.path,
    builder: (context, state) {
      return Routes.splash.screen;
    },
  ),
  GoRoute(
    path: Routes.login.path,
    builder: (context, state) {
      return Routes.login.screen;
    },
  ),
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, child) {
        return PageLayout(
          body: child,
          location: state.fullPath ?? Routes.tMain.path,
        );
      },
      routes: [
        GoRoute(
          path: Routes.tMain.path,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state) {
            return Routes.tMain.screen;
          },
        ),
        GoRoute(
            path: Routes.tMessaging.path,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return Routes.tMessaging.screen;
            }),
        GoRoute(
            path: Routes.tHistory.path,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return Routes.tHistory.screen;
            }),
      ]),
  GoRoute(
    path: Routes.recruitment(':pageId').path,
    parentNavigatorKey: _rootNavigatorKey,
    builder: (BuildContext context, GoRouterState state) {
      if (state.pathParameters['pageId'] == null) {
        return Routes.tMain.screen;
      }
      return Routes.recruitment(state.pathParameters['pageId']!).screen;
    },
  ),
];
