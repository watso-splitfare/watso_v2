import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:watso_v2/common/router/routes.dart';

import '../auth/auth_model.dart';
import '../auth/auth_provider.dart';
import '../widgets/Layout.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter myRouter(MyRouterRef ref) {
  final isAuth = ValueNotifier<AsyncValue<Auth?>>(const AsyncLoading());
  ref
    ..onDispose(() => isAuth.dispose())
    ..listen(authControllerProvider, (_, authValue) {
      // isAuthValue is null
      log('authValue: ${authValue.value}');
      isAuth.value = AsyncData(authValue.value);

      log('isAuth: ${isAuth.value.value}');
    });

  return GoRouter(
      routes: _routes,
      navigatorKey: _rootNavigatorKey,
      initialLocation: Routes.tMain.path,
      refreshListenable: isAuth,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        // 유저 정보를 불러올때까지 로딩...
        if (isAuth.value.isLoading || !isAuth.value.hasValue) {
          return Routes.splash.path;
        }

        final auth = isAuth.value.requireValue;
        if (state.uri.path == Routes.splash.path) {
          return auth != null ? Routes.tMain.path : Routes.login.path;
        }
        if (state.uri.path == Routes.login.path) {
          return auth != null ? Routes.tMain.path : null;
        }
        return auth != null ? null : Routes.login.path;
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
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
            child: PageLayout(
          body: child,
          location: state.fullPath ?? Routes.tMain.path,
        ));
      },
      // builder: (BuildContext context, GoRouterState state, child) {
      //   return PageLayout(
      //     body: child,
      //     location: state.fullPath ?? Routes.tMain.path,
      //   );
      // },
      routes: [
        GoRoute(
          path: Routes.tMain.path,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return NoTransitionPage(child: Routes.tMain.screen);
          },
        ),
        GoRoute(
            path: Routes.tJoined.path,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: Routes.tJoined.screen);
            }),
        GoRoute(
            path: Routes.tHistory.path,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: Routes.tHistory.screen);
            }),
      ]),
  GoRoute(
      path: Routes.tCreate.path,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return Routes.tCreate.screen;
      }),
  GoRoute(
      path: Routes.tJoinedDetail(':pageId').path,
      parentNavigatorKey: _shellNavigatorKey,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return NoTransitionPage(
            child:
                Routes.tJoinedDetail(state.pathParameters['pageId']!).screen);
      }),
  GoRoute(
    path: Routes.tRecruit(':pageId').path,
    parentNavigatorKey: _rootNavigatorKey,
    builder: (BuildContext context, GoRouterState state) {
      if (state.pathParameters['pageId'] == null) {
        return Routes.tMain.screen;
      }
      return Routes.tRecruit(state.pathParameters['pageId']!).screen;
    },
  ),
];
