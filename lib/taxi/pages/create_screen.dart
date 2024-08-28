import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:watso_v2/common/constants/styles.dart';
import 'package:watso_v2/taxi/model/taxi_model.dart';

import '../provider/create_provider.dart';
import '../provider/main_provider.dart';
import '../repository/taxi_repository.dart';

class CreateScreen extends ConsumerWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CreateTaxiGroup createTaxi = ref.watch(createTaxiProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("택시 그룹 생성"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "날짜를 선택해주 세요",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "* 최대 한달 후까지 예약 가능합니다.",
              style: TextStyle(fontSize: 11),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: createTaxi.departDatetime,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    ).then((value) {
                      if (value != null) {
                        ref.read(createTaxiProvider.notifier).changeDate(value);
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: WatsoColor.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(DateFormat("yy년 MM월 dd일")
                      .format(createTaxi.departDatetime))),
            ),
            SizedBox(height: 12),
            Text(
              "인원 설정",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "* 인원은 최소 2명부터 최대 5명까지 가능합니다.",
              style: TextStyle(fontSize: 11),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      createTaxi.maxMember <= 2
                          ? null
                          : ref
                              .read(createTaxiProvider.notifier)
                              .removeMember();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${createTaxi.maxMember} 명',
                      style: TextStyle(fontSize: 16, color: WatsoColor.primary),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      createTaxi.maxMember >= 4
                          ? null
                          : ref.read(createTaxiProvider.notifier).addMember();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "방향 설정",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("* 버튼을 누를 시 변경 가능합니다.", style: TextStyle(fontSize: 11)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  ref.read(createTaxiProvider.notifier).changeDirection();
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: WatsoColor.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  createTaxi.direction == TaxiDirection.CAMPUS
                      ? "캠퍼스 -> 역"
                      : "역 -> 캠퍼스",
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: WatsoColor.primary,
                  foregroundColor: Colors.white),
              onPressed: () async {
                log(createTaxi.toString());
                log(createTaxi.toJson().toString());
                try {
                  await ref
                      .read(taxiRepositoryProvider)
                      .createTaxiGroup(group: createTaxi);
                  final filterFunc = ref.read(filterOptionsProvider.notifier);
                  filterFunc.changeDirection(direction: createTaxi.direction);
                  filterFunc.changeDate(createTaxi.departDatetime);
                  context.pop();
                } catch (e) {
                  log(e.toString());
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("그룹 생성 실패"),
                          content: Text("그룹 생성에 실패했습니다. 다시 시도해주세요."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("확인"),
                            ),
                          ],
                        );
                      });
                }
              },
              child: Text("그룹 생성"),
            ),
          ],
        ),
      ),
    );
  }
}
