import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:watso_v2/common/constants/styles.dart';

import '../../common/router/routes.dart';
import '../../common/widgets/Boxes.dart';
import '../widgets/crateTaxi_dialog.dart';

class TaxiMainScreen extends StatefulWidget {
  const TaxiMainScreen({super.key});

  @override
  State<TaxiMainScreen> createState() => _TaxiMainScreenState();
}

class _TaxiMainScreenState extends State<TaxiMainScreen> {
  DateTime _selectedDate = DateTime.now();
  String departure = "부산대 밀양캠";
  String destination = "밀양역";

  _beforeDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
    });
  }

  _afterDate() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
  }

  _changeDeparture() {
    String tmp = departure;
    setState(() {
      departure = destination;
      destination = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/left-arrow.svg",
                      ),
                      onPressed: _beforeDate,
                    ),
                    Text(
                      "${DateFormat("MM").format(_selectedDate)}월 ${_selectedDate.day}일",
                      style: WatsoFont.title.copyWith(color: Colors.white),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/right-arrow.svg",
                      ),
                      onPressed: _afterDate,
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      print("calendar");
                    },
                    icon: SvgPicture.asset("assets/icons/calendar.svg"))
              ],
            ),
            AngularBox(
              height: 140,
              child: Stack(children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "출발",
                                style: TextStyle(color: Color(0xFF767676)),
                              ),
                              SizedBox(height: 4),
                              Text(
                                departure,
                                style: WatsoFont.mainBody,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "도착",
                                style: TextStyle(color: Color(0xFF767676)),
                              ),
                              SizedBox(height: 4),
                              Text(
                                destination,
                                style: WatsoFont.mainBody,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                    child: InkWell(
                  onTap: () {
                    _changeDeparture();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Color(0xFF767676),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        "assets/icons/fluent-arrow.svg",
                      ),
                    ),
                  ),
                )),
              ]),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("택시리스트", style: WatsoFont.title),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("출발도착지 ∙ 출발 시간 ∙ 총요금 ∙  정원",
                  style: TextStyle(color: Colors.grey[600], fontSize: 11)),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < 10; i++) ...{
                  InkWell(
                      onTap: () {
                        context.push(Routes.recruitment(i.toString()).path);
                      },
                      child: AngularBox(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset("assets/icons/pin.svg"),
                                        SizedBox(width: 8),
                                        Text(
                                          destination,
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
                                  Text("10:00AM"),
                                  Text("6200원"),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("1/4명"),
                                      SvgPicture.asset("assets/icons/group.svg"),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                }
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 110,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CreateTaxiDialog(userID: 123,);
                });
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: WatsoColor.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.add_box_rounded,
                color: Colors.white,
                size: 30,
              ),
              Text(
                '팀 만들기',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
