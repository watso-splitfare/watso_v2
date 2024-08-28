import 'package:flutter/material.dart';
import 'package:watso_v2/taxi/pages/create_screen.dart';
import 'package:watso_v2/taxi/pages/joined_screen.dart';

import '../../taxi/pages/history_screen.dart';
import '../../taxi/pages/login_screen.dart';
import '../../taxi/pages/main_screen.dart';
import '../../taxi/pages/messaging_screen.dart';
import '../../taxi/pages/recruitment_screen.dart';
import '../../taxi/pages/splash_screen.dart';

class Route {
  final Widget screen;
  final String path;

  const Route(this.screen, this.path);
}

class Routes {
  // common
  static const splash = Route(SplashScreen(), '/splash');
  static const login = Route(LoginScreen(), '/login');

  // taxi main routes
  static const tMain = Route(TaxiMainScreen(), '/taxi/main');

  static const tJoined = Route(JoinedScreen(), '/taxi/joined');

  static Route tJoinedDetail(String id) =>
      Route(MessagingScreen(pageId: int.tryParse(id) ?? 0), '/taxi/joined/$id');
  static const tHistory = Route(HistoryScreen(), '/taxi/history');

  // taxi sub routes
  static const tCreate = Route(CreateScreen(), '/taxi/main/create');

  static Route tRecruit(String id) => Route(
      TaxiRecruitmentScreen(pageId: int.tryParse(id) ?? 0),
      '/taxi/main/recruitment/$id');

//delivery
}
