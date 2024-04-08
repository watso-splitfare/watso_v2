import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

import '../../common/constants/styles.dart';
import '../../common/widgets/Boxes.dart';

class RecuitInfoCard extends StatelessWidget {
  final String departure;
  final String destination;
  final int maxPeople;
  final int currentPeople;
  final DateTime departTime;
  final int estimatedCost;

  const RecuitInfoCard({
    super.key,
    required this.departure,
    required this.destination,
    required this.maxPeople,
    required this.currentPeople,
    required this.departTime,
    required this.estimatedCost,
  });

  // convert DateTime to 10:00AM format
  String departTimeToString(DateTime departTime) =>
      "${departTime.hour}:${departTime.minute}${departTime.hour > 12 ? "PM" : "AM"}";

  @override
  Widget build(BuildContext context) {
    int costPerPerson = estimatedCost ~/ maxPeople;
    return RoundBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/group.svg",
                      colorFilter:
                          ColorFilter.mode(WatsoColor.primary, BlendMode.srcIn),
                    ),
                    SizedBox(width: 4),
                    Text("$currentPeople/$maxPeople명",
                        style: WatsoFont.thinTitle),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/direction.svg"),
                      SizedBox(width: 8),
                      Text(
                        departure,
                        style: WatsoFont.mainBody,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/pin.svg"),
                      SizedBox(width: 8),
                      Text(
                        destination,
                        style: WatsoFont.mainBody,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TileContentBox(
                  title: "출발 시간",
                  content: departTimeToString(departTime),
                ),
                TileContentBox(
                  title: "예상금액",
                  content: "$estimatedCost원",
                ),
                TileContentBox(
                  title: "1인당 요금",
                  content: "$costPerPerson원",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
