import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:watso_v2/common/utils/utils.dart';
import 'package:watso_v2/common/widgets/Boxes.dart';
import 'package:watso_v2/taxi/model/taxi_model.dart';
import 'package:watso_v2/taxi/repository/taxi_repository.dart';

import '../../common/constants/styles.dart';
import '../../common/router/routes.dart';
import '../../common/widgets/Buttons.dart';

class TaxiRecruitmentScreen extends ConsumerWidget {
  const TaxiRecruitmentScreen({super.key, required this.pageId});

  final int pageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("택시 모집", style: WatsoFont.title),
        centerTitle: true,
        backgroundColor: WatsoColor.primary,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Stack(children: [
        Column(
          children: [
            Expanded(child: Container(color: WatsoColor.primary)),
            Expanded(child: Container(color: WatsoColor.background)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FutureBuilder(
              future:
                  ref.watch(taxiRepositoryProvider).getTaxiGroup(id: pageId),
              builder:
                  (BuildContext context, AsyncSnapshot<TaxiGroup> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                final TaxiGroup group = snapshot.data!;

                final String destination = group.direction.toKorean();
                final String departure = group.direction == TaxiDirection.CAMPUS
                    ? TaxiDirection.STATION.toKorean()
                    : TaxiDirection.CAMPUS.toKorean();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundBox(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: Image.asset("assets/images/map1.png",
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/group.svg",
                                      colorFilter: ColorFilter.mode(
                                          WatsoColor.primary, BlendMode.srcIn),
                                    ),
                                    Text(
                                        "${group.member.currentMember}/${group.member.maxMember}명",
                                        style: WatsoFont.thinTitle),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/direction.svg"),
                                        SizedBox(width: 8),
                                        Text(
                                          departure,
                                          style: WatsoFont.mainBody,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/pin.svg"),
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
                              Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TileContentBox(
                                    title: "출발 시간",
                                    content:
                                        convertTimeAMPM(group.departDatetime),
                                  ),
                                  TileContentBox(
                                    title: "총 예상금액",
                                    content: "${group.fee.cost}원",
                                  ),
                                  TileContentBox(
                                    title: "1인당 요금",
                                    content: "${group.fee.cost}원",
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                                child: Text(
                                  "예상 금액은 실제 비용과 차이가 있을 수 있습니다.",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                    // SizedBox(height: 20),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: PrimaryBtn(
                        minimumSize: Size(double.infinity, 48),
                        onPressed: () {
                          context.go(Routes.tJoined.path);
                        },
                        text: "탑승하기",
                      ),
                    ),
                  ],
                );
              }),
        ),
      ]),
    );
  }
}
