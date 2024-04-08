import 'package:flutter/material.dart';

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

  // taxi
  static const tMain = Route(TaxiMainScreen(), '/taxi/main');
  static const tMessaging = Route(MessagingScreen(), '/taxi/messaging');
  static const tHistory = Route(HistoryScreen(), '/taxi/history');

  static Route recruitment(String id) =>
      Route(TaxiRecruitmentScreen(pageId: id), '/taxi/recruitment/$id');

//delivery
}
