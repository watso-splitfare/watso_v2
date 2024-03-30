import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../constants/styles.dart';
import '../router/routes.dart';

class PageLayout extends StatefulWidget {
  const PageLayout({
    super.key,
    required this.body,
    required this.location,
  });

  final Widget body;
  final String location;

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  _location() {
    String path = widget.location;
    if (path == Routes.tMain.path) return 0;
    if (path == Routes.tMessaging.path) return 1;
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
              SliverFillRemaining()
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget.body,
          ),
        ]),

        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: widget.body,
        //   ),
        // ),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  context.go(Routes.tMain.path);
                },
                child: Container(
                  height: 32,
                  width: 32,
                  padding: const EdgeInsets.all(2),
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      _location() == 0 ? WatsoColor.primary : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.go(Routes.tMessaging.path);
                },
                child: SvgPicture.asset(
                  'assets/icons/bigtalk.svg',
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                    _location() == 1 ? WatsoColor.primary : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.go(Routes.tHistory.path);
                },
                child: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                    _location() == 2 ? WatsoColor.primary : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
