import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:flutter_svg_provider/flutter_svg_provider.dart' show Svg;

import '../../common/constants/styles.dart';
import '../../common/widgets/Boxes.dart';
import '../../common/widgets/Buttons.dart';
import '../widgets/receipt_dialog.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  String departure = "부산대";
  String destination = "밀양역";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RoundBox(
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
                          colorFilter: ColorFilter.mode(
                              WatsoColor.primary, BlendMode.srcIn),
                        ),
                        Text("2/4명", style: WatsoFont.thinTitle),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: PrimaryBtn(
            minimumSize: Size(double.infinity, 48),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const ReceiptDialog(payment: 6300, hc: 3);
                  });
            },
            text: "탑승자 확정하기",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Text("채팅방", style: WatsoFont.title),
        ),
        //   make chat room
        Expanded(
            child: RoundBox(
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: Svg('assets/icons/profile.svg',
                              color: Colors.white),
                          //svg
                          // AssetImage("assets/images/profile.png"),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("전민지", style: WatsoFont.mainBody),
                                SizedBox(width: 8),
                                Text("10:00AM", style: WatsoFont.tag),
                              ],
                            ),
                            TextBox(
                              text: "탑승자 4/4 모이면 확정할게요~",
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("10:01AM", style: WatsoFont.tag),
                                SizedBox(width: 8),
                                Text("전민지", style: WatsoFont.mainBody),
                              ],
                            ),
                            TextBox(
                              text: "탑승자 4/4 모이면 확정할게요~",
                            )
                          ],
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: Svg('assets/icons/profile.svg',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        hintText: "메시지를 입력하세요",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                      )),
                    ),
                    SizedBox(width: 8),
                    PrimaryBtn(
                      color: Color(0xFF767676),
                      onPressed: () {},
                      minimumSize: Size(80, 40),
                      text: "전송",
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
