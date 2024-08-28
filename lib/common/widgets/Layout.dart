import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../taxi/widgets/main_floating_btn.dart';
import '../constants/styles.dart';
import '../router/routes.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.body,
    required this.location,
  });

  final Widget body;
  final String location;

  _location() {
    String path = location;
    if (path == Routes.tMain.path) return 0;
    if (path == Routes.tJoined.path) return 1;
    if (path == Routes.tHistory.path) return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: WatsoColor.primary,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            "택시왔소",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/receipt.svg",
              semanticsLabel: "영수증",
            ),
            onPressed: () {
              print("영수증");
            },
            splashColor: Colors.transparent,
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/setting.svg",
              semanticsLabel: "설정",
            ),
            onPressed: () {
              print("설정");
            },
            splashColor: Colors.transparent,
          ),
          IconButton(
            padding: EdgeInsets.all(10),
            icon: SvgPicture.asset(
              "assets/icons/notification.svg",
              semanticsLabel: "알림",
            ),
            onPressed: () {
              print("알림");
            },
            splashColor: Colors.transparent,
          ),
        ],
      ),
      body: Stack(children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                color: WatsoColor.primary,
              ),
            ),
            SliverFillRemaining(
              child: Container(
                color: WatsoColor.background,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: body,
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: WatsoColor.primary,
        onTap: (index) {
          if (index == 0) {
            context.go(Routes.tMain.path);
          } else if (index == 1) {
            context.go(Routes.tJoined.path);
          } else if (index == 2) {
            context.go(Routes.tHistory.path);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                _location() == 0 ? WatsoColor.primary : Colors.black12,
                BlendMode.srcIn,
              ),
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bigtalk.svg',
              height: 32,
              width: 32,
              colorFilter: ColorFilter.mode(
                _location() == 1 ? WatsoColor.primary : Colors.black12,
                BlendMode.srcIn,
              ),
            ),
            label: "메시징",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              height: 32,
              width: 32,
              colorFilter: ColorFilter.mode(
                _location() == 2 ? WatsoColor.primary : Colors.black12,
                BlendMode.srcIn,
              ),
            ),
            label: "히스토리",
          ),
        ],
      ),
      floatingActionButton: _location() == 0 ? MainFloatingBtn() : null,
    );
  }
}
