import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/router/routes.dart';
import '../../common/widgets/Boxes.dart';
import '../model/taxi_model.dart';
import '../repository/taxi_repository.dart';
import '../widgets/recuit_info_card.dart';
import 'messaging_screen.dart';

class JoinedScreen extends ConsumerWidget {
  const JoinedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.watch(taxiRepositoryProvider).getJoinedTaxiGroups(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget? child;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              child = CircularProgressIndicator();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                child = Text("Error: ${snapshot.error}");
              }
              if (snapshot.data.isEmpty) {
                child = Text("참여 중인 택시가 없습니다");
                break;
              }
          }
          if (child != null) {
            return AngularBox(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: child,
            );
          }

          final List<TaxiGroup> groups = snapshot.data;

          if (groups.length == 1) {
            return MessagingScreen(pageId: groups[0].id);
          }
          return ListView.builder(
              itemCount: groups.length,
              itemBuilder: (BuildContext context, int index) {
                final TaxiGroup group = groups[index];
                return GestureDetector(
                  onTap: () {
                    context
                        .push(Routes.tJoinedDetail(group.id.toString()).path);
                  },
                  child: RecuitInfoCard(
                      departure: group.direction.toKorean(),
                      destination: group.direction == TaxiDirection.STATION
                          ? TaxiDirection.CAMPUS.toKorean()
                          : TaxiDirection.STATION.toKorean(),
                      maxPeople: group.member.maxMember,
                      currentPeople: group.member.currentMember,
                      departTime: group.departDatetime,
                      estimatedCost: group.fee.cost),
                );
              });
        });
  }
}
