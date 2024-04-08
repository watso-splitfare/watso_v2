import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:watso_v2/common/widgets/Boxes.dart';

import '../../common/constants/styles.dart';
import '../../common/router/routes.dart';
import '../../common/widgets/Buttons.dart';

class TaxiRecruitmentScreen extends StatefulWidget {
  const TaxiRecruitmentScreen({super.key, required this.pageId});

  final String pageId;

  @override
  State<TaxiRecruitmentScreen> createState() => _TaxiRecruitmentScreenState();
}

class _TaxiRecruitmentScreenState extends State<TaxiRecruitmentScreen> {
  String departure = "부산대";
  String destination = "밀양역";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("택시 모집"),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: RoundBox(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.asset("assets/images/map1.png",
                          fit: BoxFit.cover),
                    )),
                    Expanded(
                        child: Padding(
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
                                Text("2/4명", style: WatsoFont.thinTitle),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "이 택시는 터미널 3번 출구에서 출발해서 법학전문대학원 정문에서 내릴 예정입니다. 시간 늦으시면 지체없이 출발하겠습니다..",
                              style: WatsoFont.mainBody,
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TileContentBox(
                                title: "출발 시간",
                                content: "10:00AM",
                              ),
                              TileContentBox(
                                title: "예상금액",
                                content: "6200원",
                              ),
                              TileContentBox(
                                title: "1인당 요금",
                                content: "2100",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: PrimaryBtn(
                  minimumSize: Size(double.infinity, 48),
                  onPressed: () {
                    context.go(Routes.tMessaging.path);
                  },
                  text: "탑승하기",
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ]),
    );
  }
}
