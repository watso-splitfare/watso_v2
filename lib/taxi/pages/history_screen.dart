import 'package:flutter/material.dart';
import 'package:watso_v2/common/constants/styles.dart';

import '../widgets/recuit_info_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Column(children: [
        TabBar(
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Color(0xffFFFFFF).withOpacity(0.5),
          labelStyle: WatsoFont.title,
          unselectedLabelStyle: WatsoFont.title,
          // indicator none
          indicator: BoxDecoration(),
          tabs: [
            Tab(text: "택시 내역"),
            Tab(text: "영수증"),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              ListView(
                children: [
                  RecuitInfoCard(
                    departure: "부산대",
                    destination: "밀양역",
                    maxPeople: 4,
                    currentPeople: 3,
                    departTime: DateTime.now(),
                    estimatedCost: 20000,
                  ),
                  RecuitInfoCard(
                    departure: "부산대",
                    destination: "밀양역",
                    maxPeople: 4,
                    currentPeople: 3,
                    departTime: DateTime.now(),
                    estimatedCost: 20000,
                  ),
                ],
              ),
              ListView(
                children: [
                  RecuitInfoCard(
                    departure: "부산대",
                    destination: "밀양역",
                    maxPeople: 4,
                    currentPeople: 3,
                    departTime: DateTime.now(),
                    estimatedCost: 20000,
                  ),
                  RecuitInfoCard(
                    departure: "부산대",
                    destination: "밀양역",
                    maxPeople: 4,
                    currentPeople: 3,
                    departTime: DateTime.now(),
                    estimatedCost: 20000,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
