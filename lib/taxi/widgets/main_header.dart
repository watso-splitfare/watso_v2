import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:watso_v2/taxi/model/taxi_model.dart';

import '../../common/constants/styles.dart';
import '../../common/widgets/Boxes.dart';
import '../provider/main_provider.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TaxiOption filter = ref.watch(filterOptionsProvider);
    DateTime selectedDate = filter.departDatetime;
    TaxiDirection destination = filter.direction;
    TaxiDirection departure = destination == TaxiDirection.CAMPUS
        ? TaxiDirection.STATION
        : TaxiDirection.CAMPUS;

    final filterFunctions = ref.read(filterOptionsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  onPressed: filterFunctions.beforeDate,
                ),
                Text(
                  "${DateFormat("MM").format(selectedDate)}월 ${selectedDate.day}일",
                  style: WatsoFont.title.copyWith(color: Colors.white),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/right-arrow.svg",
                  ),
                  onPressed: filterFunctions.afterDate,
                ),
              ],
            ),
            IconButton(
                onPressed: () async {
                  //   showDatePicker
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000));
                  if (picked != null) {
                    filterFunctions.changeDate(picked);
                  }
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
                            departure.toKorean(),
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
                            destination.toKorean(),
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
              onTap: filterFunctions.changeDirection,
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
      ],
    );
  }
}
